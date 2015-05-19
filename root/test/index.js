{% if (coffeescript) { %}assert = require 'assert'


describe '{%= name %}', ->
  it 'is true!', ->
    assert require '../index'{% } else { %}var assert = require('assert');

describe('{%= name %}', function() {
  it('is true!', function() {
    assert(require('../index'));
  });
});{% } %}
