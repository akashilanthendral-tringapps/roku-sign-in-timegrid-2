sub init()
    print "firstVideoComponent: init()"
    m.top.setFocus(true)
    print "m.top.hasFocus(): "m.top.hasFocus()
    ' m.top.observeField("focusedChild", "handleFocusedChild")
    m.firstVideo = m.top.findNode("firstVideo")
    m.firstVideo.observeField("itemFocused", "onVideoFocused")
    m.firstVideo.observeField("state", "handleState")
end sub

' sub handleFocusedChild()
'     if m.top.hasFocus()
'         m.firstVideo.control = "stop"
'     end if
' end sub

sub setContent()
    print "setContent()"
    m.values = m.top.itemContent

    m.videoUrl = m.values.videoUrl
    m.videoTitle = m.values.videoTitle
    m.videoControl = m.values.videoControl
    m.videoStreamFormat = m.values.videoStreamFormat
    setVideo()
end sub

function setVideo() as void
    print " setVideo()"
    videoContent = createObject("RoSGNode", "ContentNode")
    videoContent.url = m.videoUrl
    videoContent.title = m.videoTitle
    videoContent.streamformat = m.videoStreamFormat
  
    ' m.video = m.top.findNode("videoId")
    ' m.video.observeField("state", "handleState")
    m.firstVideo.content = videoContent
    m.firstVideo.control = m.videoControl
    'm.firstVideo.setFocus(true)
    print "................"
    print "m.firstVideo.hasFocus(): "m.firstVideo.hasFocus()
    print "................"
   
end function


sub handleState()
    print "handleState()"
    if m.firstVideo.state = "finished"
        m.firstVideo.control = "stop"
        print "m.firstVideo.hasFocus(): "m.firstVideo.hasFocus()
        print "m.top.hasFocus(): "m.top.hasFocus()
    end if
end sub

sub onVideoReceivedFocus(event)
    shouldPlay = event.getData()
    if shouldPlay = true
        m.firstVideo.control = "play"
    else
        m.firstVideo.control = "stop"
    end if
end sub

function onKeyEvent(press as boolean, key as String) as boolean
    if press
        if key = "left"
            print "left handled"
            return true
        end if
    end if
    return false
end function
