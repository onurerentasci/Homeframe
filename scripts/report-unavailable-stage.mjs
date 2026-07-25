const stage = process.argv[2];

const messages = {
  device:
    "test:device — NOT_APPLICABLE (S0): Android host uygulaması S1 fizibilite sprintinde eklenecek.",
};

if (stage === undefined || messages[stage] === undefined) {
  console.error(`Bilinmeyen kapı aşaması: ${stage ?? "<boş>"}`);
  process.exitCode = 1;
} else {
  console.log(messages[stage]);
}
