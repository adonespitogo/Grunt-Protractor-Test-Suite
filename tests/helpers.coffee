
module.exports =

  getChoices: (cb) ->
    choices = element.all(By.repeater('Choice in Question.Choices'))

    choices.count().then (count) ->

      choicesArr = []

      for i in [0...count]
        elem = choices.get(i)
        choicesArr.push elem

      cb choicesArr

  isCorrectAnswer: (choice, cb) ->
    correctIndicator = choice.element(By.css('span.glyphicon.glyphicon-ok.green'))
    correctIndicator.isDisplayed().then (displayed) ->
      cb displayed

  modalContains: (regex, cb) ->
    element(By.className('modal-dialog')).getText().then (text) ->
      cb regex.test text

  alertContains: (regex, cb) ->
    element(By.css('gameplayQuestionAnswerContainer')).getText().then (text) ->
      cb regex.test text