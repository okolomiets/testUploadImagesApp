util = require("util")

# local files list
list = []

exports.imageForm = (req, res) ->
  res.render "upload",
    list: list

  return

exports.uploadImage = (req, res, next) ->
  unless req.files.image.size is 0 or req.body.title is ''
    console.log "request info: ", req

    pathArray = req.files.image.path.split("/")
    now = new Date()
    fixDate = (d) ->
      (if d < 10 then "0" + d else d)
    modidied = fixDate(now.getDate())+'/'+fixDate(now.getMonth()+1)+'/'+now.getFullYear()+' '+fixDate(now.getHours())+':'+fixDate(now.getMinutes())

    object =
      path: "images/" + pathArray[(pathArray.length - 1)]
      title: req.body.title
      size: req.files.image.size / 1024 | 0
      modified: modidied

    list.push object

  res.render "upload",
    list: list
  return