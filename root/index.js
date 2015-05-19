{% if (coffeescript) { %}module.exports = -> true{% } else { %}module.exports = function() {
  return true;
};{% } %}
