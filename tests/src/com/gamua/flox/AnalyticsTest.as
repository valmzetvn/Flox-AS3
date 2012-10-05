package com.gamua.flox
{
    import flash.utils.setTimeout;
    
    import starling.unit.UnitTest;

    public class AnalyticsTest extends UnitTest
    {
        public function testSession(onComplete:Function):void
        {
            // nothing to actually test here, because the analytics class just uploads the 
            // data and can't retrieve it from the server. This test is solely an easy way to
            // step through the code.
            
            var restService:RestService = new RestService(Constants.BASE_URL,
                                                          Constants.GAME_ID,
                                                          Constants.GAME_KEY);
            
            var gameSession:GameSession = GameSession.start(restService);
            
            var numbers:Array = [10, 20, 30];
            var strings:Array = ["hugo", "berti", "sepp"];
            var booleans:Array = [false, true];
            var eventProperties:Object = {
                "number":   numbers[int(Math.random() * numbers.length)],
                "string":   strings[int(Math.random() * strings.length)],
                "boolean":  booleans[int(Math.random() * booleans.length)]
            };
            
            gameSession.logInfo("This is the first info log");
            gameSession.logWarning("This is a warning log");
            gameSession.logError("Error");
            gameSession.logError("AnotherError", "Additional Information");
            gameSession.logEvent("AnalyticsTestExecuted");
            gameSession.logEvent("EventWithProperties", eventProperties);
            gameSession.logInfo("This is the last info log");
            
            setTimeout(endSession, 1100);
            
            function endSession():void
            {
                // start another session - only now will the previous session be transmitted!
                GameSession.start(restService);
                setTimeout(onComplete, 200);
            }
        }
    }
}