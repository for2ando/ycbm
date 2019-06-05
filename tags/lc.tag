<!-- The definition of lc (LocalizedContents) tag -->

<lc>
  <yield/>
  
  this.on('mount', function() {
    this.root.innerText = lc(this.root.innerText)
  })
</lc>
