import React from "react";
import { SafeAreaView, StyleSheet, Text, View } from "react-native";

export function App() {
  return React.createElement(
    SafeAreaView,
    { style: styles.screen },
    React.createElement(
      View,
      { style: styles.content },
      React.createElement(Text, { style: styles.eyebrow }, "HOMEFRAME / S1"),
      React.createElement(Text, { style: styles.title }, "Native feasibility host"),
      React.createElement(
        Text,
        { style: styles.body },
        "The Android home-screen widget renders independently from this React Native surface.",
      ),
    ),
  );
}

const styles = StyleSheet.create({
  body: {
    color: "#57574f",
    fontSize: 16,
    lineHeight: 24,
    marginTop: 16,
  },
  content: {
    padding: 28,
  },
  eyebrow: {
    color: "#696960",
    fontSize: 12,
    letterSpacing: 2,
  },
  screen: {
    backgroundColor: "#f4f0e8",
    flex: 1,
  },
  title: {
    color: "#171714",
    fontSize: 34,
    fontWeight: "700",
    marginTop: 10,
  },
});
