sub init()
    m.name = m.top.findNode("name")
    m.iconUri = m.top.findNode("iconUri")


end sub

sub setContent()
    m.itemContentValues = m.top.itemContent
    m.name.text = m.itemContentValues.name
    m.iconUri.uri = m.itemContentValues.iconUri

end sub