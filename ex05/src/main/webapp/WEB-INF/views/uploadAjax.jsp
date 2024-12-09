<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>Upload with Ajax</h1>

	<div class='uploadDiv'>
		<input type='file' name='uploadFile' multiple>
	</div>

	<style>
.uploadReslut {
	width: 100% background-colorl grey;
}

.uploadResult ul {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
}

.uploadResult ul li img {
	width: 20px;
}
</style>

	<div class='uploadResult'>
		<ul>

		</ul>
	</div>

	<div class='bigPictureWrapper'>
		<div class='bigpicture'></div>
	</div>

	<style>
.uploadResult {
	width: 100%;
	background-color: gray;
}

.uploadResult ul {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
	align-content: center;
	text-align: center;
}

.uploadResult ul li img {
	width: 100px;
}

.uploadResult ul li span {
	color: white;
}

.bigPictureWrapper {
	position: absolute;
	display: none;
	justify-content: center;
	align-items: center;
	top: 0%;
	width: 100%;
	height: 100%;
	background-color: gray;
	z-index: 100;
	background: rgba(255, 255, 255, 0.5);
}

.bigpicture {
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}

.bigPicture img {
	width: 600px;
}
</style>
	<button id='uploadBtn'>Upload</button>

	<script src="http://code.jquery.com/jquery-3.3.1.min.js"
		integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
		crossorigin="anonymous"></script>

	<script>
	
		function showImage(fileCallPath){
			
			// alert(fileCallPath);
			
			$(".bigPictureWrapper").on("click", function(e){
				$(".bigPicture").animate({width:'0%', height: '0%'}, 1000)
				setTimeout(function(){
					$('.bigPictureWrapper').hide();
				}, 1000);
				});
		
		$(document).ready(function() {

			var cloneObj = $(".uploadDiv").clone();

			$("#uploadBtn").on("click", function(e) {

				var formData = new FormData();

				var inputFile = $("input[name='uploadFile']");

				var files = inputFile[0].files;

				console.log(files);

				//add filedate to formdata
				for (var i = 0; i < files.length; i++) {

					formData.append("uploadFile", files[i]);
				}

				$.ajax({
					url : '/uploadAjaxAction',
					processData : false,
					contentType : false,
					data : formData,
					type : 'Post',
					success : function(result) {
						alert("upload");

					}
				});// $.ajax

			});
		});

		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize = 5242880;

		function checkExtension(fileName, fileSize) {

			if (fileSize >= maxSize) {
				alert("파일 사이즈 초과");
				return false;
			}

			if (regex.test(fileName)) {
				alert("해당 종류의 파일은 업로드 할 수 없습니다.");
				return false;
			}
			return true;
		}

		$("#uploadBtn").on("click", function(e) {

			var formData = new FormData();

			var inputFile = $("input[name='uploadFile']");

			var files = inputFile[0].files;

			console.log(files);

			for (var i = 0; i < files.length; i++) {

				if (!checkExtension(file[i].name, files[i].size)) {
					return false;
				}

				formData.append("uploadFile", files[i]);
			}

			$.ajax({
				url : '/uploadAjaxAction',
				processData : false,
				contentType : false,
				data : formData,
				type : 'Post',
				dataType : 'json',
				success : function(result) {

					console.log(result);

					showUploadFile(result);

					$(".uploadDiv").html(cloneObj.html());
					
					function showUploadFile(uploadResultArr){
						
						var str = "";
						
						$(uploadResultArr).each(
						function(i, obj){
							
							if (!obj.image){
								str += "<li><img src='/resources/img/attach.png'>"
									+ obj.fileName + "</li>";
								}else {
									str += "<li>" + obj.fileName + "</li>";
								}
						});
						uploadResult.append(str);
				}
			});
		});
		
		function showUPloadedFile(uploadResultArr){
			
			var str = "";
			
			$(uploadResultArr).each(function(i, obj){
				
				if(!obj.image){
					
					var fileCallPath = encodeURIComponent( obj.uploadPath"/" + obj.uuid + "_" +obj.fileName);
				}
					str +="<li><div><a href='/download?fileName="+fileCallPath+"'>"+
							"<img src='/resources/img/attach.png'>"+obj.fileName+"</a>"+
							"<span data-file=\'"+fileCallPath"\' data-type='file'> x </span>"+"<div></li>"
				}else{
					//str += "<li>"+ obj.fileName+"</li>";
					
					var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
					
					originPath = originPath.replace(new RegExp(/\\/g), "/");
					
					str += "<li><a href=\"javescript:showImage(\'"+originPath+"\')\"><img src='/display?fileName="+fileCallPath+"'></a>"+
							"<span data-file=\'"+fileCallPath"\' data-type='file'> x </span>"+"<li>";
				}
		});
			
			uploadResult.append(str);
		}
		
		$(".uploadResult").on("click", "span", function(e){
		
			var targetFile = $(this).data("file");
			var type = $(this).data("type");
			console.log(targetFile);
			
			$.ajax({
				url: '/deleteFile',
				data: {fileName: targetFile, type:type}.
				dataType: 'POST',
					successL function(result){
						alert(result);
				}
			});
		});			
	</script>
</body>
</html>