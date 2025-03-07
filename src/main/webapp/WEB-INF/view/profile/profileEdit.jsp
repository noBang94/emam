<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>프로필 변경</title>
</head>
<body>
<h1>프로필 변경</h1>
<form action="/profile/editProfile.do" method="post" enctype="multipart/form-data">
    <label for="profileIntro">자기소개:</label><br>
    <textarea id="profileIntro" name="profileIntro" rows="4" cols="50">${profile.profileIntro}</textarea><br><br>

    <label for="profileHeaderPhoto">배경 사진:</label><br>
    <input type="file" id="profileHeaderPhoto" name="profileHeaderPhoto"><br><br>

    <label for="profilePhoto">프로필 사진:</label><br>
    <input type="file" id="profilePhoto" name="profilePhoto"><br><br>

    <label for="profileUrl">프로필 URL:</label><br>
    <input type="text" id="profileUrl" name="profileUrl" value="${profile.profileUrl}"><br><br>


    <input type="submit" value="변경">
</form>
</body>
</html>