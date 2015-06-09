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

