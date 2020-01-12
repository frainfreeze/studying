"use strict";

function clean() {
  $('#profile-img').empty();
  $('#profile-name').empty();
  $('#profile-info').empty();
  $('#profile-bio').empty();
  $('#ghapidata').empty();
  $('#the-repos').empty();
}

$(function () {
  $('#myForm').on('submit', function (e) {
    e.preventDefault();
    clean();
    var username = $('#ghusername').val();
    var requri = 'https://api.github.com/users/' + username;
    var repouri = 'https://api.github.com/users/' + username + '/repos';

    requestJSON(requri, function (json) {
      if (json.message == "Not Found" || username == '') {
        $('#ghapidata').html("<h2>No User Info Found</h2>");
      } else {
        var fullname = json.name;
        var username = json.login;
        var aviurl = json.avatar_url;
        var profileurl = json.html_url;
        var followersnum = json.followers;
        var followingnum = json.following;
        var reposnum = json.public_repos;
        var bio = json.bio;

        if (fullname == undefined) {
          fullname = username;
        }

        $('#profile-img').prepend('<img alt="profile pic" class="avatar width-full rounded-2" src="' + aviurl + '" width="230" height="230">')
        $('#profile-name').prepend('<span class="p-nickname vcard-username d-block" itemprop="additionalName"><a href="' + profileurl + '" target="_blank">' + username + '</a></span>')
        $('#profile-info').prepend('<div class="ghcontent"><div class="avi"><a href="' + profileurl +
          '" target="_blank"></a></div>' + '<p>Followers: ' + followersnum +
          ' - Following: ' + followingnum + '<br>Repos: ' + reposnum + '</p></div>')
        $('#profile-bio').prepend(bio);

        $.getJSON(repouri, function (json) {
          if (json.length == 0) {
            $("#the-repos").append('<p>No repos!</p></div>');
          } else {
            $.each(json, function (index) {
              let src = `
              <li class="col-12 d-block width-full py-4 border-bottom public source" itemprop="owns" itemscope="" itemtype="http://schema.org/Code">
              <div class="d-inline-block mb-1">
                <h3><a href="${json[index].url}" itemprop="name codeRepository">${json[index].name}</a></h3>
              </div>
              <div>
                <p class="col-9 text-gray">${json[index].description}</p>
              </div>
              <div class="f6 text-gray mt-2">
                <span class="mr-3" itemprop="programmingLanguage">${json[index].language}</span> - Updated ${json[index].updated_at}</relative-time>
              </div>
              </li>`;
              $("#the-repos").append(src);
            });
          }
        });
      }
    });
  });

  function requestJSON(url, callback) {
    $.ajax({
      url: url,
      complete: function (xhr) {
        callback.call(null, xhr.responseJSON);
      }
    });
  }

});