describe 'Student Gameplay', ->

  it 'should load `Challenges` page after login', ->

    browser.get 'https://alpha.khmath.com/App#/Login'
    element(By.model('loginData.Username')).sendKeys('Angelo')
    element(By.model('loginData.Password')).sendKeys('abcd')

    element(By.css('#btnLogin')).click()

    challengesPageCheck = /Challenges$/

    browser.getCurrentUrl().then (url) ->
      expect( challengesPageCheck.test url ).toBe true

  describe 'Stars and XP count', ->

    it 'should be greater then 0', ->
      element(By.css('.studentCountersBar .counterBlockStars span')).getText().then (count) ->
        expect(parseInt count).toBeGreaterThan 0

      element(By.css('.studentCountersBar .counterBlockXp span')).getText().then (count) ->
        expect(parseInt count).toBeGreaterThan 0