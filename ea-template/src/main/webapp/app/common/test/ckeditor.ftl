<#include "../../../common/freemarker/include_header.ftl">
<html>
<head>
    <title>CKEditor Classic Editing Sample</title>
    <!-- Make sure the path to CKEditor is correct. -->
    <script src="common/ckeditor/ckeditor.js"></script>
</head>
<body>
    <form method="post">
        <p>
            My Editor:<br>
            <textarea name="editor1" id="editor1">&lt;p&gt;Initial value.&lt;/p&gt;</textarea>
            <script>
                CKEDITOR.replace( 'editor1' );
            </script>
        </p>
        <p>
            <input type="submit">
        </p>
    </form>
</body>
</html>