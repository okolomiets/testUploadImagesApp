util = require("util")
fs = require("fs")

# local files list
list = []

exports.imageForm = (req, res) ->
  res.render "upload",
    list: list

  return

exports.uploadImage = (req, res, next) ->
  unless req.files.image.size is 0 or req.body.title is ''
    #console.log "request info: ", req

    pathArray = req.files.image.path.split("/")
    now = new Date()
    fixDate = (d) ->
      (if d < 10 then "0" + d else d)
    modidied = fixDate(now.getDate())+'/'+fixDate(now.getMonth()+1)+'/'+now.getFullYear()+' '+fixDate(now.getHours())+':'+fixDate(now.getMinutes())

    object =
      full_path: req.files.image.path
      path: "images/" + pathArray[(pathArray.length - 1)]
      title: req.body.title
      size: req.files.image.size / 1024 | 0
      modified: modidied

    list.push object

  res.render "upload",
    list: list
  return

exports.getImage = (req, res) ->
  id = req.params.id
  record = list[id-1]
  res.render "record",
    id: id
    object: record

  return

exports.deleteImage = (req, res) ->
  id = req.params.id-1
  full_path = list[id].full_path
  fs.unlink full_path, (err) ->
    throw err  if err
    console.log "successfully deleted " + full_path
    return
  list.splice id, 1
  res.redirect "/upload"
#  res.render "upload",
#    list: list

  return

