<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>프로필 변경</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
        }

        body {
            background-color: #f9fafb;
            color: #333;
            line-height: 1.6;
        }

        .container {
            max-width: 800px;
            margin: 2rem auto;
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .header {
            background-color: #2196F3;
            color: white;
            padding: 1.5rem 2rem;
            position: relative;
        }

        .header h1 {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .header p {
            font-size: 1rem;
            opacity: 0.9;
        }

        .form-container {
            padding: 2rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
            animation: fadeIn 0.5s ease-out;
        }

        .form-label {
            display: block;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: #374151;
            font-size: 1rem;
        }

        .form-control {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.2s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: #4f46e5;
            box-shadow: 0 0 0 2px rgba(79, 70, 229, 0.2);
        }

        textarea.form-control {
            min-height: 120px;
            resize: vertical;
        }

        .file-input-container {
            position: relative;
            margin-top: 0.5rem;
        }

        .file-input-label {
            display: inline-block;
            padding: 0.75rem 1.25rem;
            background-color: #f3f4f6;
            color: #4b5563;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.2s ease;
            border: 1px solid #d1d5db;
        }

        .file-input-label:hover {
            background-color: #e5e7eb;
        }

        .file-input-label i {
            margin-right: 0.5rem;
        }

        .file-input {
            position: absolute;
            width: 0.1px;
            height: 0.1px;
            opacity: 0;
            overflow: hidden;
            z-index: -1;
        }

        .file-name {
            margin-left: 1rem;
            font-size: 0.9rem;
            color: #6b7280;
        }

        .preview-container {
            margin-top: 1rem;
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .image-preview {
            width: 100%;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            display: none;
        }

        .header-preview {
            height: 150px;
            background-size: cover;
            background-position: center;
        }

        .profile-preview {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            border: 4px solid white;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .profile-preview img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .btn-container {
            display: flex;
            justify-content: space-between;
            margin-top: 2rem;
        }

        .btn {
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
            font-size: 1rem;
            border: none;
        }

        .btn-primary {
            background-color: #2196F3;
            color: white;
            box-shadow: 0 2px 5px rgba(79, 70, 229, 0.3);
        }

        .btn-primary:hover {
            background-color: #4338ca;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(79, 70, 229, 0.4);
        }

        .btn-secondary {
            background-color: #f3f4f6;
            color: #4b5563;
        }

        .btn-secondary:hover {
            background-color: #e5e7eb;
        }

        .form-footer {
            background-color: #f9fafb;
            padding: 1.5rem 2rem;
            border-top: 1px solid #e5e7eb;
        }

        .form-footer p {
            font-size: 0.9rem;
            color: #6b7280;
        }

        /* 애니메이션 효과 */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .form-group:nth-child(1) { animation-delay: 0.1s; }
        .form-group:nth-child(2) { animation-delay: 0.2s; }
        .form-group:nth-child(3) { animation-delay: 0.3s; }
        .form-group:nth-child(4) { animation-delay: 0.4s; }

        /* 반응형 디자인 */
        @media (max-width: 768px) {
            .container {
                margin: 1rem;
                border-radius: 8px;
            }

            .header {
                padding: 1.25rem 1.5rem;
            }

            .form-container {
                padding: 1.5rem;
            }

            .btn {
                padding: 0.6rem 1.2rem;
            }
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            // 파일 선택 시 파일명 표시
            $('.file-input').change(function() {
                var fileName = $(this).val().split('\\').pop();
                if (fileName) {
                    $(this).siblings('.file-name').text(fileName);

                    // 이미지 미리보기
                    if (this.files && this.files[0]) {
                        var reader = new FileReader();
                        var previewId = $(this).attr('id') === 'profileHeaderPhoto' ? 'headerPreview' : 'profilePreview';

                        reader.onload = function(e) {
                            if (previewId === 'headerPreview') {
                                $('#' + previewId).css('background-image', 'url(' + e.target.result + ')');
                            } else {
                                $('#' + previewId + ' img').attr('src', e.target.result);
                            }
                            $('#' + previewId).show();
                        }

                        reader.readAsDataURL(this.files[0]);
                    }
                } else {
                    $(this).siblings('.file-name').text('');
                }
            });

            // 취소 버튼 클릭 시 이전 페이지로 이동
            $('#cancelBtn').click(function(e) {
                e.preventDefault();
                window.history.back();
            });
        });
    </script>
</head>
<body>
<div class="container">
    <div class="header">
        <h1><i class="fas fa-user-edit"></i> 프로필 변경</h1>
        <p>프로필 정보를 수정하여 나만의 개성을 표현해보세요.</p>
    </div>

    <div class="form-container">
        <form action="/profile/editProfile.do" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="profileIntro" class="form-label"><i class="fas fa-comment-alt"></i> 자기소개</label>
                <textarea id="profileIntro" name="profileIntro" class="form-control" placeholder="자신을 소개하는 글을 작성해주세요.">${profile.profileIntro}</textarea>
            </div>

            <div class="form-group">
                <label for="profileHeaderPhoto" class="form-label"><i class="fas fa-image"></i> 배경 사진</label>
                <div class="file-input-container">
                    <label for="profileHeaderPhoto" class="file-input-label">
                        <i class="fas fa-upload"></i> 파일 선택
                    </label>
                    <input type="file" id="profileHeaderPhoto" name="profileHeaderPhoto" class="file-input" accept="image/*">
                    <span class="file-name"></span>
                </div>
                <div class="preview-container">
                    <div id="headerPreview" class="image-preview header-preview"></div>
                </div>
            </div>

            <div class="form-group">
                <label for="profilePhoto" class="form-label"><i class="fas fa-user-circle"></i> 프로필 사진</label>
                <div class="file-input-container">
                    <label for="profilePhoto" class="file-input-label">
                        <i class="fas fa-upload"></i> 파일 선택
                    </label>
                    <input type="file" id="profilePhoto" name="profilePhoto" class="file-input" accept="image/*">
                    <span class="file-name"></span>
                </div>
                <div class="preview-container">
                    <div id="profilePreview" class="image-preview profile-preview">
                        <img src="#" alt="프로필 미리보기">
                    </div>
                </div>
            </div>

            <div class="form-group">
                <label for="profileUrl" class="form-label"><i class="fas fa-link"></i> 프로필 URL</label>
                <input type="text" id="profileUrl" name="profileUrl" class="form-control" placeholder="https://example.com" value="${profile.profileUrl}">
            </div>

            <div class="btn-container">
                <button type="button" id="cancelBtn" class="btn btn-secondary"><i class="fas fa-times"></i> 취소</button>
                <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> 변경 저장</button>
            </div>
        </form>
    </div>

    <div class="form-footer">
        <p><i class="fas fa-info-circle"></i> 프로필 사진과 배경 사진은 각각 5MB 이하의 이미지 파일만 업로드 가능합니다.</p>
    </div>
</div>
</body>
</html>

