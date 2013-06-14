var techTestButton = document.getElementById('run_tech_test');
techTestButton.addEventListener('click', runTechTest, false);

function runTechTest(event){
  event.preventDefault();

  var startTime, vid, i;

  if (window.techTestRunning) return;
  window.techTestRunning = true;

  var html5Div = document.getElementById('html5_test');
  var flashDiv = document.getElementById('flash_test');
  var flashCount = 0;
  var flashTimes = [];

  var flashHTML = '<object type="application/x-shockwave-flash" data="swf/video-js.swf" width="100%" height="100%" id="vid1_flash_api" name="vid1_flash_api" class="vjs-tech" style="display: block;"><param name="movie" value="swf/video-js.swf"><param name="flashvars" value="readyFunction=flashReady&amp;eventProxyFunction=flashEvent&amp;errorEventProxyFunction=flashError&amp;preload=none"><param name="allowScriptAccess" value="always"><param name="allowNetworking" value="all"><param name="wmode" value="opaque"><param name="bgcolor" value="#ffffff"></object>';
  window.flashReady = function(){
    console.log('flash ready');
    flashTimes.push(Date.now() - startTime);
    flashDiv.innerHTML = '';

    if (flashCount < 9) {
      flashCount++;
      flashTest();
    } else {
      flashDiv.innerHTML = '<h3>FLASH DONE!</h3><p>AVG: '+getAverage(flashTimes)+'ms</p>';
    }
  };  
  function flashTest() {
    startTime = Date.now();
    flashDiv.innerHTML = flashHTML;
  }

  var html5Count = 0;
  var html5Times = [];
  var html5HTML = '<video id="temp_vid" controls style="width: 350px; height:150px; background-color: #fff;"></video>';
  var html5Ready = function(){
    var tempVid = document.getElementById('temp_vid');
    if (tempVid.src === '') { // Video element API is ready for a source
      console.log('html5 ready');
      html5Times.push(Date.now() - startTime);
      html5Div.innerHTML = '';

      if (html5Count < 9) {
        html5Count++;
        html5Test();
      } else {
        html5Div.innerHTML = '<h3>HTML5 DONE!</h3><p>AVG: '+getAverage(html5Times)+'ms</p>';
        flashTest();
      }
    } else {
      // Wait 10ms and try again
      // This is all for show, and to be consistent with the Flash checking
      // The element API will be ready immediately.
      setTimeout(html5Ready, 10);
    }
  };
  function html5Test() {
    startTime = Date.now();
    html5Div.innerHTML = html5HTML;
    html5Ready();
  }

  function getAverage(arr){
    var sum = 0;
    for (var i = arr.length - 1; i >= 0; i--) {
      sum += arr[i];
    };
    return (sum / arr.length);
  }

  html5Test();

  window.techTestRunning = false;
  return false;
}