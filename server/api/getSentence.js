const axios = require("axios");

const getSentence = async () => {
  const jokeData = await axios.get("https://api.chucknorris.io/jokes/random");

  return jokeData.data.value.split(" ");
};

module.exports = getSentence;
