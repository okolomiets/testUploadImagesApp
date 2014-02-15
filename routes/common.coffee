util = require("util")
exports.imageForm = (req, res) ->
  res.render "upload",
    title: "Upload Images"

  return

exports.uploadImage = (req, res, next) ->
  console.log "file info: ", req.files.image

  #split the url into an array and then get the last chunk and render it out in the send req.
  pathArray = req.files.image.path.split("/")

  #, req.files.image
  res.send util.format(" Task Complete \n uploaded %s (%d Kb) to %s", req.files.image.name, req.files.image.size / 1024 | 0, req.files.image.path, req.body.title, "<img src=\"images/" + pathArray[(pathArray.length - 1)] + "\">")
  return