sub init()
    m.top.setFocus(true)
    m.top.observeField("focusedChild", "setFocusToMyList")

    m.layoutGroupId = m.top.findNode("layoutGroupId")

    m.playButton = m.top.findNode("playButton")
    m.buttonGroupId = m.top.findNode("buttonGroupId")
    m.leftMarkUpGridList = m.top.findNode("leftMarkUpGridList")
    m.leftMarkUpGridListAnimation = m.top.findNode("leftMarkUpGridListAnimation")
    m.leftMarkUpGridListAnimationWhenUnfocused = m.top.findNode("leftMarkUpGridListAnimationWhenUnfocused")
    m.markUpGridBackgroundWhenFocused = m.top.findNode("markUpGridBackgroundWhenFocused")
    m.markUpGridBackgroundWhenUnfocused = m.top.findNode("markUpGridBackgroundWhenUnfocused")
    
    m.homeComponentId = m.top.findNode("homeComponentId")
    m.searchComponentId = m.top.findNode("searchComponentId")
    m.profileComponentId = m.top.findNode("profileComponentId")
    m.timeGridComponentId = m.top.findNode("timeGridComponentId")
    
    printTimeGridComp(m.timeGridComponentId)
    printProfileComp(m.profileComponentId)

    m.componentsArray = [m.homeComponentId, m.searchComponentId, m.profileComponentId, m.timeGridComponentId]
    m.previousComp = m.homeComponentId

    m.leftMarkUpGridList.observeField("itemFocused", "onMarkUpGridIsFocused")
    m.leftMarkUpGridList.observeField("itemSelected", "onMarkUpGridSelected")
    m.playButton.observeField("buttonSelected", "onPlayButtonSelected")

    setLeftMarkUpGridItems()
    setHomeComponent()
end sub

sub printTimeGridComp(ob as dynamic)
    print "Inside: printTimeGridComp"
    print "m.timeGridComponentId: "ob
end sub

sub printProfileComp(ob as dynamic)
    print "Inside: printTimeGridComp"
    print "clippingRect: "ob.clippingRect
end sub

sub setHomeComponent()
    m.homeComponentId.visible = true
    m.previousComp = m.homeComponentId
    m.previousComp.setFocus = true
end sub

sub onMarkUpGridSelected()
    selectedItemIndex = m.leftMarkUpGridList.itemSelected
    selectedItem = m.leftMarkUpGridList.content.getChild(selectedItemIndex)

    if selectedItem.name = "Sign out"
        onLogoutButtonSelected()
    else 
        renderComponent()
    end if
end sub

sub renderComponent()

    selectedItemIndex = m.leftMarkUpGridList.itemSelected
    selectedItem = m.leftMarkUpGridList.content.getChild(selectedItemIndex)
    compName = selectedItem.componentName
    compToRender = m.top.findNode(compName)

    m.leftMarkUpGridListAnimationWhenUnfocused.control = "start"
    m.markUpGridBackgroundWhenUnfocused.control = "start"

    m.previousComp.setFocus = false
    m.previousComp.visible = false
    m.previousComp = compToRender
    compToRender.setFocus = true
    compToRender.visible = true
    ' i = 0
    ' while i < m.componentsArray.Count()
    '     print "Inside while"
    '     if i <> selectedItem
            
    '         m.componentsArray[i].setFocus = false
    '         m.componentsArray[i].visible = false
    '     else
    '         print "i = selectedItem: "i
    '         print "setfocus triggered"
    '         print "item selected: "m.leftMarkUpGridList.content.getChild(selectedItem)
    '         m.leftMarkUpGridListAnimationWhenUnfocused.control = "start"
    '         m.markUpGridBackgroundWhenUnfocused.control = "start"
    '         m.componentsArray[i].visible = true
    '         m.componentsArray[i].setFocus = true
            
    '         m.previousComp = m.componentsArray[i]
    '     end if
    '     i = i + 1
    ' end while
    
    ' if selectedItem = 0
        
    ' else if selectedItem = 3
    '     comp = m.componentsArray[0]
    '     m.previousComp = comp 
    '     m.playButton.setFocus(false)
    '     comp.visible = true
    '     comp.setFocus = true
    ' end if

end sub

sub renderLiveComponent()
    timeGridComponent = CreateObject("rosgnode", "timeGridComponent")
    m.top.appendChild(timeGridComponent)
    timeGridComponent.setFocus(true)
end sub

sub setLeftMarkUpGridItems()

    m.markUpGridItemContents = [
        {
            "name": "Home",
            "iconUri": "pkg:/images/separated/homeIconColored.png",
            "componentName": "homeComponentId"            
        },
        {
            "name": "Search",
            "iconUri": "pkg:/images/separated/searchIconBlue2.png",
            "componentName": "searchComponentId"
        },
        {
            "name": "Profile",
            "iconUri": "pkg:/images/separated/profileIcon.png",
            "componentName": "profileComponentId"
        },
        {
            "name": "Live",
            "iconUri": "pkg:/images/separated/liveIcon.png",
            "componentName": "timeGridComponentId"
        },
        {
            "name": "Sign out",
            "iconUri": "pkg:/images/separated/signoutIcon.png",
            "componentName": ""
        }
    ]


    parentContent = CreateObject("roSGNode", "contentNode")

    for each item in m.markUpGridItemContents
        childContent = parentContent.createChild("leftMarkUpGridContent")
        childContent.iconUri = item.iconUri
        childContent.name = item.name
        childContent.componentName = item.componentName
    end for

    m.leftMarkUpGridList.content = parentContent
end sub

sub setFocusToMyList()

    if m.top.hasFocus()
        m.playButton.setFocus(true)
    end if

end sub

sub onLogoutButtonSelected()
    m.top.getScene().deleteBackStackArray = true
    m.top.getScene().logOut = true
    m.top.getScene().compToPush = "loginComponent"

end sub

' sub onPlayButtonSelected()

'     m.top.getScene().compToPush = "videoComponent"

' end sub

function onKeyEvent(key as string, press as boolean) as boolean
    if press
        if key = "right"
            print "Right key pressed"
            if m.leftMarkUpGridList.hasFocus()
                print "m.leftMarkUpGridList.hasFocus(): "m.leftMarkUpGridList.hasFocus()
                m.leftMarkUpGridListAnimationWhenUnfocused.control = "start"
                m.markUpGridBackgroundWhenUnfocused.control = "start"
                
                m.previousComp.setFocus = true
                ' m.playButton.setFocus(true)
                return true
            end if
        else if key = "left"
            if m.playButton.hasFocus()
                m.leftMarkUpGridListAnimation.control = "start"
                m.markUpGridBackgroundWhenFocused.control = "start"
                m.leftMarkUpGridList.setFocus(true)
                return true
            else if NOT m.leftMarkUpGridList.hasFocus() 
                m.leftMarkUpGridListAnimation.control = "start"
                m.markUpGridBackgroundWhenFocused.control = "start"
                m.leftMarkUpGridList.setFocus(true)
                return true
            else
                print "else part handled"
                m.leftMarkUpGridListAnimation.control = "start"
                m.markUpGridBackgroundWhenFocused.control = "start"
                m.leftMarkUpGridList.setFocus(true)
            end if
        
        else if key = "back"
            ' m.leftMarkUpGridList.setFocus(true)
            m.leftMarkUpGridListAnimation.control = "start"
            m.markUpGridBackgroundWhenFocused.control = "start"
            m.leftMarkUpGridList.setFocus(true)
            return true
        else if key = "ok"
            if m.leftMarkUpGridList.hasFocus()

            end if
        end if
    return false
    end if
end function