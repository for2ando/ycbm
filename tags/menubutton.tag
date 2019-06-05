<!-- The definition of menubutton tag -->

<menubutton>
  <button ref='buttonbody' class='buttonbody' onclick={button_click}>
    {title}
  </button>
  <yield/>
  
  var self = this
  this.title = opts.title
  
  this.on('mount', function() {
    this.ref('buttonbody').button({
      icons: { secondary: 'ui-icon-triangle-1-s' }
    })
    this.ref('menu').menu().hide()
  })
  
  /*defmethod*/ button_click(evt) {
    this.ref('menu').toggle()
    evt.stopPropagation()
  }
  $(document).on('click', function(evt) {
    if(!$.contains(self.ref('menu')[0], evt.target)
       && !$.contains(self.ref('buttonbody')[0], evt.target)) {
      // clicked on a document off the button
      self.ref('menu').hide()
    }
  })
</menubutton>
