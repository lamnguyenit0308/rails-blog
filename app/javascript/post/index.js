// $(function() {
//   //Click upload
//   $('.btn-select-cover-photo').on('click', function() {
//     console.log(111)
//     $('#post_cover_photo_link').click()
//   })

//   //Onchange file
//   $('#post_cover_photo_link').change(function (event) {
//     const files = event.target.files
//     if (files.length) {
//       const file = files[0]
//       const reader = new FileReader();
//       reader.onload = function(e) {
//         $('#preview-image').attr('src', e.target.result);
//       };
//       reader.readAsDataURL(file);
//     }
//   })

//   //Delete file
//   $('.btn-delete-cover-photo').on('click', function() {
//     $('#preview-image').attr('src', "");
//     $('#post_cover_photo_link').val("")
//   })
// })