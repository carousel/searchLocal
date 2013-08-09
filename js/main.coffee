#local search application
# written by Miroslav Trninic email:miroslav.trninic@gmail.com
# https://github.com/carouel


#local database 
#by default db text/link points to wikipedia articles
data = ["charlie Parker"
       ,"john Coltrane"
       ,"miles Davis"
       ,"joe Pass"
       ,"max Roach"
       ,"dizzie Gillespie"
       ,"bud Powell"
       ,"charles Mingus"
       ,"sonny Rollins"
       ,"django Reindhardt"
       ,"duke ellington"
       ,"albert ayler"
       ,"louis armstrong"
       ,"billie holiday"
       ]

# start point/user input
$("input").on "keydown",(e)->
    setTimeout(inputDispatch,150,e)

# insert results into DOM
insertListItem = (a) ->
    "<a><li style='list-style-type:none'>" + a + "</li></a>"
    
# match results while typing
matchForward= (input)->
    for key of data
        if input is data[key].charAt(input.length-1) 
            $("li").addClass("li:first-letter")
            insertListItem(data[key]) 
        else if input is data[key].substr(0,2)
            insertListItem(data[key])
        else if input is data[key].substr(0,3) or input  is data[key].substr(0,4) or
        input is data[key].substr(0,5) or input is data[key].substr(0,6)
            insertListItem(data[key]) 

# match results while pressing backspace
matchBack = ()->
    for key of data
        if $("input").val() is data[key].substr(0,6)
            insertListItem(data[key])
        else if $("input").val() is data[key].substr(0,5)
            insertListItem(data[key])
        else if $("input").val() is data[key].substr(0,4)
            insertListItem(data[key])
        else if $("input").val() is data[key].substr(0,3)
            insertListItem(data[key])
        else if $("input").val() is data[key].substr(0,2)
            insertListItem(data[key])
        else if $("input").val() is data[key].substr(0,1)
            insertListItem(data[key])

#linkify results
addLink = () ->
   $("ul").find("li").on("click",(e)->
       href = $(@).text()
       $(@).parent().attr("href","http://en.wikipedia.org/wiki/" + href)
   )

#add hover effect
hoverOverLink = ()->
   $("ul").find("a").hover(
       ()->
           $(@).addClass("hover")
       ()->
           $(@).removeClass("hover")
   )

# dispatch action based on key type
inputDispatch = (e)->
    e.preventDefault()
    if e.keyCode != 8
       $("ul").html(matchForward(e.target.value,e)).addClass("match")
       hoverOverLink()
       addLink()
    else if e.keyCode is 8
        $("ul").html(matchBack())
        hoverOverLink()
        addLink()
        #if we are at the end, remove class
        if $("input").val().length <= 0
            $("ul").removeClass("match")

    











