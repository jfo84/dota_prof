$(document).ready(function() {
  var flag = true;

  $(".like").on("click", function( event ) {
    event.preventDefault();
    var submissionId = event.currentTarget.id;
    var score = document.getElementById("score-" +
      submissionId
    ).innerHTML;
    score = parseInt(score);
    if (flag) {
      score++;
      document.getElementById("score-" + submissionId).textContent = score;

      $.ajax({
        type: 'PUT',
        url: event.currentTarget.parentElement.parentElement.href,
        dataType: 'json',
        success: function(data) {

      }
      });
    } else {
      score--;
      document.getElementById("score-" + submissionId).textContent = score;

      unvote_Url = event.currentTarget.parentElement.parentElement.href
      unvote_Url = unvote_Url.slice(0,-4) + "unlike"

      $.ajax({
        type: 'PUT',
        url: unvote_Url,
        dataType: 'json',
        success: function(data) {

      }
      });
    }
    flag = !flag;
  });
});
