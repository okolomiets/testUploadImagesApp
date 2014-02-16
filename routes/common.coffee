util = require("util")

# local files list
list = []

exports.imageForm = (req, res) ->
  res.render "upload",
    list: list

  return

exports.uploadImage = (req, res, next) ->
  unless req.files.image.size is 0
    console.log "request info: ", req

    pathArray = req.files.image.path.split("/")
    now = new Date()
    modidied = now.getDate()+'/'+(now.getMonth()+1)+'/'+now.getFullYear()+' '+now.getHours()+':'+now.getMinutes()

    object =
      path: "images/" + pathArray[(pathArray.length - 1)]
      title: req.body.title
      size: req.files.image.size / 1024 | 0
      modified: modidied

    list.push object

  res.render "upload",
    list: list
  return