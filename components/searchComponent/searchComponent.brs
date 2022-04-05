sub init()

    m.firstVideoMUG = m.top.findNode("firstVideoMUG")
    m.firstVideoMUG.setFocus(true)
    m.firstVideoMUG.observeField("itemUnfocused", "onMGUnfocused")
    m.firstVideo = m.top.findNode("firstVideo")
    print " m.firstVideo: "m.firstVideo

end sub

sub onMGUnfocused()

end sub

function getVideoDetails() as object
    videoDetails = {
        "url": "https://roku.s.cpl.delvenetworks.com/media/59021fabe3b645968e382ac726cd6c7b/60b4a471ffb74809beb2f7d5a15b3193/roku_ep_111_segment_1_final-cc_mix_033015-a7ec8a288c4bcec001c118181c668de321108861.m3u8",
        "title" : "Test Video",
        "streamformat" : "hls",
        "control": "play"
    }
    return videoDetails
end function
sub onSetFocus(event)
    print "onSetFocus: SEARCH COMPONENT"
    videoDetails = getVideoDetails()
    parentContent = CreateObject("roSGNode", "ContentNode")
    childContent = parentContent.createChild("firstVideoItemField")
    childContent.videoUrl = videoDetails.url
    childContent.videoTitle = videoDetails.title
    childContent.videoStreamFormat = videoDetails.streamFormat
    childContent.videoControl = videoDetails.control
    print "Content assigned"
    m.firstVideoMUG.content = parentContent
    print "after Content assigned"
    m.firstVideoMUG.setFocus(true)
    print "m.firstVideoMUG.hasFocus(): "m.firstVideoMUG.hasFocus()
end sub

function onKeyEvent(press as boolean, key as String) as boolean
    if press
        if key = "left"
            print "left clicked"
            
            return 
        end if
    end if
end function