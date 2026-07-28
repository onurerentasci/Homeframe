type LayoutChild = {
  id: string;
  type: "countdown" | "text";
};

type WidgetIr = {
  irVersion: 1;
  widget: {
    layout: {
      children: LayoutChild[];
      padding: number;
      type: "column";
    };
    name: string;
  };
};

function isRecord(value: unknown): value is Record<string, unknown> {
  return typeof value === "object" && value !== null;
}

function parseIr(value: unknown): WidgetIr {
  if (!isRecord(value) || value.irVersion !== 1 || !isRecord(value.widget)) {
    throw new TypeError("HF-S1: irVersion=1 olan bir widget IR girdisi gerekli.");
  }

  const { layout, name } = value.widget;
  if (
    typeof name !== "string" ||
    !isRecord(layout) ||
    layout.type !== "column" ||
    typeof layout.padding !== "number" ||
    !Number.isFinite(layout.padding) ||
    !Array.isArray(layout.children)
  ) {
    throw new TypeError("HF-S1: geçersiz column widget düzeni.");
  }

  const children = layout.children.map((child) => {
    if (
      !isRecord(child) ||
      (child.type !== "text" && child.type !== "countdown") ||
      typeof child.id !== "string" ||
      !/^[a-z][a-z0-9_]*$/.test(child.id)
    ) {
      throw new TypeError("HF-S1: yalnızca kimlikli text/countdown çocukları desteklenir.");
    }

    const type: LayoutChild["type"] = child.type;
    return { id: child.id, type };
  });

  return {
    irVersion: 1,
    widget: {
      layout: {
        children,
        padding: layout.padding,
        type: "column",
      },
      name,
    },
  };
}

function childXml(child: LayoutChild): string {
  const tag = child.type === "text" ? "TextView" : "Chronometer";
  const countdownAttribute =
    child.type === "countdown" ? '\n        android:countDown="true"' : "";

  return `    <${tag}
        android:id="@+id/${child.id}"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"${countdownAttribute} />`;
}

export function generateAndroidLayout(input: unknown): string {
  const { layout } = parseIr(input).widget;
  const children = layout.children.map(childXml).join("\n");

  return `<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:id="@+id/homeframe_root"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:importantForAccessibility="yes"
    android:orientation="vertical"
    android:padding="${layout.padding}dp"
    android:screenReaderFocusable="true">
${children}
</LinearLayout>
`;
}
