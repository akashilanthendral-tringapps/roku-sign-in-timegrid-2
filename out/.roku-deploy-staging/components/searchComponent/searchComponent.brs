sub init()

    m.firstVideoMUG = m.top.findNode("firstVideoMUG")
    m.outerLayoutGroup = m.top.findNode("outerLayoutGroup")
    m.firstVideoMUG.setFocus(true)
    m.firstVideoMUG.observeField("itemSelected", "onFirstMUGSelected")

    m.isVideoEnlarged = false
    

end sub

sub setLayoutGroupTranslation(leftOrCenter)
    if leftOrCenter = "left"
        m.outerLayoutGroup.translation = "[230,0]"
    else 
        m.outerLayoutGroup.translation = "[300, 400]"
    end if
   
end sub

sub setIsVideoEnlarged(value)
    m.isVideoEnlarged = value
end sub

function getIsVideoEnlarged() as boolean
    return m.isVideoEnlarged
end function

sub setFirstVideoMarkUpGridItemSize()
    if getIsVideoEnlarged()
        m.firstVideoMUG.itemSize = "[1600, 1000]"
    else
        m.firstVideoMUG.itemSize = "[600, 300]"
    end if
end sub

sub onFirstMUGSelected()
    setIsVideoEnlarged(true)
    setLayoutGroupTranslation("left")
    setFirstVideoMarkUpGridItemSize()
    m.childContent.increaseVideoSize = "true"
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
    m.parentContent = CreateObject("roSGNode", "ContentNode")
    m.childContent = m.parentContent.createChild("firstVideoItemField")
    m.childContent.videoUrl = videoDetails.url
    m.childContent.videoTitle = videoDetails.title
    m.childContent.videoStreamFormat = videoDetails.streamFormat
    m.childContent.videoControl = videoDetails.control
    m.childContent.increaseVideoSize = "false"
    m.firstVideoMUG.content = m.parentContent
    m.firstVideoMUG.setFocus(true)
    
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    if press
        if key = "left"
            print "left clicked"
            if getIsVideoEnlarged()
                setIsVideoEnlarged(false)
                setLayoutGroupTranslation("center")
                setFirstVideoMarkUpGridItemSize()
            end if
            m.childContent.videoControl = "stop"
            return false
        else if key="back"
            print "back pressed"
            if getIsVideoEnlarged()
                setIsVideoEnlarged(false)
                setLayoutGroupTranslation("center")
                setFirstVideoMarkUpGridItemSize()
                m.childContent.increaseVideoSize = "false"
                return true
            else
                m.childContent.videoControl = "stop"
                return false
            end if
        end if
        
    end if
    return false
end function