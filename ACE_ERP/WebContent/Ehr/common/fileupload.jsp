<%@ page pageEncoding="euc-kr"%>
    
    <script language=javascript src="../../common/fileupload.js"></script>    
    
    <!-- 데이터셋 컴포넌트 선언 [파일 첨부용] -->
    <object id="dsFILE" classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <param name="Syncload" value="true">
    </object>

    <!-- 가우스 파일 오브젝트 -->
    <object id=foFILE classid=CLSID:C722848E-C7EE-4DC6-947E-C2CD49BBA9DE style="display:none" >
        <param name="Enable"    value="true">
    </object>    
    
    <!-- 트랜젝션 선언 [파일 첨부용] -->
    <Object ID="trFILE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>    

    <script for=trFILE event="OnSuccess()">
        if(dsFILE.CountRow > 0) {
            fnc_GetFileList(dsFILE.NameValue(1, "KEY"));
        }
    </script>

    <script for=trFILE event="OnFail()">
        cfErrorMsg(this);
    </script>