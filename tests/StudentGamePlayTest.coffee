helpers = require './helpers'

describe 'Student Gameplay', ->

  it 'should load Challenges page', (done) ->

    loginUrl = 'https://alpha.khmath.com/App#/Login'

    browser.get loginUrl

    browser.getCurrentUrl().then (url) ->
      element(By.model('loginData.Username')).sendKeys('Angelo')
      element(By.model('loginData.Password')).sendKeys('abcd')
      element(By.css('#btnLogin')).click()

      challengesPageCheck = /Challenges$/

      browser.getCurrentUrl().then (url) ->
        expect( challengesPageCheck.test url ).toBe true
        done()

  it 'should have stars and xp counter working', ->
    element(By.css('.studentCountersBar .counterBlockStars span')).getText().then (count) ->
      expect(parseInt count).toBeGreaterThan 0

    element(By.css('.studentCountersBar .counterBlockXp span')).getText().then (count) ->
      expect(parseInt count).toBeGreaterThan 0

  it 'should proceed to questions page', (done) ->

    unit7 = element(By.repeater('Section in StudentClass.Sections').row 5)
    unit7.element(By.css('.topicTitle')).getText().then (title) ->
      titleTest = /Properties of Linear Relationships/
      expect(titleTest.test title).toBe true

      unit7.element(By.css('a.accordion-toggle .topicsTable')).click()

      setTimeout ->
        act1 = unit7.element(By.repeater('Activity in Section.Activities').row 0)
        act1.element(By.css('a.topic-block')).click()
        element(By.css('.btnCloseWorkedExample')).click()
        done()
      , 500

  it 'should open "Correct!" modal', (done)  ->

    correctText = /Correct!/

    helpers.getChoices (choices) ->
      makeCb = (i) ->
        (isCorrect) ->
          if isCorrect
            choices[i].click()
            helpers.modalContains correctText, (contains) ->
              expect(contains).toBe true
              done()

      for c, i in choices
        helpers.isCorrectAnswer c, makeCb i

  it 'should upload solution', (done) ->
    # http://stackoverflow.com/questions/21305298/how-to-upload-file-in-angularjs-e2e-protractor-testing
    path = require 'path'

    file = './test_solution.jpg'
    absolutePath = path.resolve __dirname, file

    element(By.css('.modal-dialog input[type=file]')).sendKeys absolutePath

    helpers.modalContains /Solution uploaded!/, (contains) ->
      expect(contains).toBe true
      element(By.css('.modal-dialog .gameplayNextButtonContainer .btn')).click()
      done()

  it 'should show “Incorrect, try again” message', (done) ->

    incorrectText = /Incorrect, try again/
    hasChoosen = false

    helpers.getChoices (choices) ->
      makeCb = (i) ->
        (isCorrect) ->
          if !isCorrect and !hasChoosen
            choices[i].click()
            hasChoosen = true
            element(By.css('.gameplayQuestionAnswerContainer .gameplayQuestion')).getText().then (text) ->
              expect(incorrectText.test text).toBe true
              done()

      for c, i in choices
        helpers.isCorrectAnswer c, makeCb i

  it 'should show "Correct!" modal on second guess with correct answer', (done) ->

    correctText = /Correct!/

    helpers.getChoices (choices) ->
      makeCb = (i) ->
        (isCorrect) ->
          if isCorrect
            choices[i].click()
            helpers.modalContains correctText, (contains) ->
              expect(contains).toBe true
              element(By.css('.modal-dialog .gameplayNextButtonContainer .btn')).click()
              done()

      for c, i in choices
        helpers.isCorrectAnswer c, makeCb i

  it 'should load this “Oops!” alert on 2 consecutive wrong answer', (done) ->

      incorrectText             = /Incorrect, try again/
      oppssText                 = /Oops! Next Question!/
      youllGetItNextTimeText    = /You'll get it next time!/
      answerCount               = 0
      index                     = 0

      helpers.getChoices (choices) ->
        makeCb = (i) ->
          (isCorrect) ->
            if !isCorrect and answerCount < 2
              choices[i].click()
              answerCount += 1

              if answerCount is 1
                element(By.css('.gameplayQuestionAnswerContainer .gameplayQuestion')).getText().then (text) ->
                  expect(incorrectText.test text).toBe true

              else if answerCount is 2
                element(By.css('.gameplayQuestionAnswerContainer .gameplayQuestion')).getText().then (text) ->
                  expect(oppssText.test text).toBe true
                  expect(youllGetItNextTimeText.test text).toBe true
                  element(By.css('.gameplayQuestionAnswerContainer .gameplayQuestionResultAlertButtons .gameplayQuestionResultAlertContinue')).click()
                  done()


        for c, i in choices
          helpers.isCorrectAnswer c, makeCb i

  it 'should load the Summary modal with 1 star', (done) ->

    star1Test = new RegExp 'images/1-stars-big.png'

    starElem = element(By.css('.modal-dialog #gameplaySummaryStarsImg'))
    starElem.getAttribute('src').then (src) ->
      expect(star1Test.test src).toBe true
      done()

  it 'should return to challeges page', (done) ->
    element(By.css('.modal-dialog .gameplaySummaryButtonContainer'))
    .element(By.xpath("//button[contains(text(),'Home')]"))
    .click()

    challengesPageCheck = /Challenges$/

    browser.getCurrentUrl().then (url) ->
      expect( challengesPageCheck.test url ).toBe true
      done()