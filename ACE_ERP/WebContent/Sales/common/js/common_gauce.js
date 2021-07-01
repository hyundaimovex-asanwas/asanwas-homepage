/*
 ***********************************************
 * @source      : common.js
 * @description : 공통자바스크립트
 ***********************************************
 * DATE         AUTHOR    DESCRIPTION
 * ---------------------------------------------
 *
 ***********************************************
*/

/**
 * @type : intro
 * @desc : common.js는 프로젝트 전반에 걸쳐 전 시스템에서 공통으로 사용하는 자바 스크립트를 기술한
 * 자바스크립트 파일이다. 빈번히 사용되는 자바스크립트들이 화면마다 반복적으로 개발되지
 * 않도록 미리 정의되어 있어서 common.js를 업무화면에 import시키기만 하면 common.js에 정의되어
 * 있는 스크립트들에 대해서는 각 개발자가 별도로 개발할 필요가 없다.
 * common.js 소스는 2개의 영역으로 구성되었다.
 * <pre>
 *     1. 공통 메세지 영역   : 화면에 사용되는 공통된 메세지들을 선언한 영역
 *     2. 공통 스크립트 영역 : 화면에 사용되는 공통 스크립트들이 기술된 영역
 * </pre>
 * 함수 Naming Rule은 다음과 같다.
 * <pre>
 *     - cf  : common function
 *     - co  : common object
 *     - cov : common object for validation
 * </pre>
 * <font color=red>※주의사항</font>
 * <pre>
 *     - common.js를 import하는 html 화면에서는 object id를 지정할 때, 다음에 나열된 id는
 *       지정할 수 없습니다.
 *
 *       coTreeViewImageComnGIDS
 * </pre>
 * @version : 3.6
 * @change  :
 * <pre>
 *     <font color="blue">V3.6</font>
 *     - cfGetCurrentDate 함수가 인증없이 수행되도록 수정.
 *     - cfStyleGrid 에서 필수컬럼제목색상 변경.
 *     - cfChangeCursor(theType) 함수 추가
 *
 *     <font color="blue">V3.5</font>
 *     - cfBuildBodyTitle 변경. 도움말 아이콘 클릭시 업무화면에 해당하는 도움말을 띄우도록 함.
 *
 *     <font color="blue">V3.4</font>
 *     - cfDisable 함수에서 버튼에 대한 disable을 두번 이상 연속 수행시 버튼 그림이 사라지는 버그수정.
 *
 *     <font color="blue">V3.3</font>
 *     - cfDisable 시에 EMEdit는 Disable, input text는 ReadOnly형태로 바뀜. 관련된 색상변경.
 *     - cfDisable 시에 Grid 버튼과 Icon 버튼에 대한 Disable 표현 추가.
 *     - Grid Validation시에 validFeatures 속성 추가.
 *     - cfSortGrid 함수 오류 수정.
 *     - validation 항목중에서 number에 대한 decimal format 을 지정할 수 있도록 기능추가.
 *     - cfBuildTitle 함수에서 회색 테두리선으로 인해 800*600 모드에서 스크롤이 생기는 현상 제거.
 *
 *     <font color="blue">V3.2</font>
 *     - Grid Validation시에 singleKey 옵션 추가.
 *     - Date.format에서 mon, day format 안되는 버그 수정.
 *     - 로그인 관련 함수 내용 수정.
 *     - cfCopyRecord 함수 추가
 *     - cfCopyDataSet 함수에  resetStatus 옵션 추가.
 *     - cfDeleteGridRows, cfUndoGridRows 함수 버그 수정.
 *     - 읽기전용항목에 대한 validation 체크시에 validation이 실패했을 경우 강제로 포커스를
 *       줌으로 인해서 생기는 스크립트 오류 수정.
 *     - cfSortGrid 함수 파라미터 변경 및 Sorting 기호표시 추가.
 *
 *     <font color="blue">V3.1</font>
 *     - 로그인관련 함수추가.
 *       cfGetLoginUserRoleCodeList(): 현재 로그인 사용자의 직무코드리스트(Array)를 반환한다.
 *       cfGetLoginUserRoleNameList(): 현재 로그인 사용자의 직무명리스트(Array)를 반환한다.
 *       cfExistLoginUserRoleName()  : 현재 로그인 사용자에게  해당 직무명이 있는지 체크 한다.
 *       cfExistLoginUserRoleCode()  : 현재 로그인 사용자에게  해당 직무코드가 있는지 체크 한다.
 *       cfGetLoginUserMPOIP ()      : 현재 로그인 사용자의 감독국 IP 를 반환한다.
 *       cfGetLoginUserRemoteAddr () : 현재 로그인 사용자의 접속 IP 를 반환한다.
 *     - cfReset 함수 오류 수정.
 *     - Date.format 메소드에서 mon, day pattern 추가.
 *     - Grid Validation 수행시에 MultiRowSelect 속성이 false인 경우 error가 발생한 Row에
 *       Mark가 제대로 가지 않던 버그 수정.
 *
 *     <font color="blue">V3.0</font>
 *     - 달력 띄울때 지정된 년/월이 최초에 뜨도록 수정.
 *     - cfFillGridHeader 호출시 DataSet에 DataId가 지정되지 않았을 경우 오류 수정.
 *
 *     <font color="blue">V2.9</font>
 *     - 로그인관련 버그수정.
 *     - Date.format 함수에서 AM/PM 오류 수정.
 *
 *     <font color="blue">V2.8</font>
 *     - cfBuildBodyTitle 함수에서 아랫쪽 회색테두리선의 위치를 20px 위로 옮김. -> 팝업창 표준에 의해
 *       팝업창의 statusbar 가 사라지게 되고 이에 따른 여백을 조정하였음.
 *
 *     <font color="blue">V2.7</font>
 *     - login과 관련된 함수들이 대폭 추가되었습니다.
 *
 *       cfGetLoginGlobalSerttingObj
 *       cfGetLoginUserId
 *       cfGetLoginUserNm
 *       cfGetLoginRegiPoCd
 *       cfGetLoginRegiPoCdNm
 *       cfGetLoginDeptCdNm
 *       cfGetLoginDeptCd
 *       cfGetLoginSectCdNm
 *       cfGetLoginSectCd
 *       cfGetLoginPosCd
 *       cfGetLoginPosCdNm
 *       cfGetLoginHrnkSancPrsnID
 *       cfGetLoginCompCd
 *       cfGetLoginInsOutUserGbCd
 *       cfGetLoginShowGlobalSertting
 *       cfGetLoginUserRoleList
 *
 *     - cfDigitalNumber 오류수정.
 *     - cfStyleGrid 에서 features에 rowHeight 옵션 추가.
 *     - 공통메시지 변경.
 *     - cfStyleTreeView 함수 추가.
 *
 *     <font color="blue">V2.6</font>
 *     - length 에러나는 오류를 수정하였습니다.
 *
 *     <font color="blue">V2.5</font>
 *     - Grid에 정의되지 않은 컬럼에 대한 validation 수행시 브라우저 오류나는 현상 수정.
 *     - Grid 표현식에서 컬럼표현식 내에 valid expression 이 없을 경우 끝에 ":" 를 붙이지 않으면 체크가
 *       되지 않았던 오류 수정.
 *     - Validation 메시지 오류 수정.
 *     - cfEnable, cfDisable, cfValidate 함수 파라미터가 Single 과 Array 형태 모두 호환 가능하도록 수정.
 *
 *     <font color="blue">V2.4</font>
 *     - Grid Validation 오류 수정.
 *
 *     <font color="blue">V2.3</font>
 *     - 새로 발표된 메시지 관리정책에 따른 공통메시지 업데이트.
 *
 *     <font color="blue">V2.2</font>
 *     - Grid Validation 버그 수정.
 *     - cfSavePageParameter 함수 버그 수정.
 *     - Grid 디자인 색상 변경에 따른 cfStyleGrid 내용변경.
 *
 *     <font color="blue">V2.1</font>
 *     - format validation 에서 한글에 대한 format 지원.
 *     - Grid validation 에서 Multi Key 에 대한 validation 지원.
 *     - cfShowCalendar 함수 개선.
 *     - cfDisable 시에 textarea 가 disabled 되지 않는 버그 수정.
 *     - filter 와 관련된 validation 항목이 filterIn 과 filterOut으로 나뉘어짐.
 *     - email validation 추가.
 *     - cfDisable 함수에서 parent 오브젝트에 대한 일괄 수행 기능 추가.
 *     - cfStyleGrid 에서 suppress 컬럼에 대한 버그 수정.
 *     - cfIsNaviPage 버그 수정.
 *     - cfFillGridNoDataMsg 함수 버그 수정.
 *     - cfSavePageParameter 함수 추가.
 *     - cfValidateMaxByteLength 함수 버그 수정.
 *
 *     <font color="blue">V2.0</font>
 *     - cfStyleGrid 에서 컬럼명 정렬을 center로 수정.
 *     - maxLength validation 사용시 문제 해결.
 *     - maxByteLength 오류시 오류메시지 수정.
 *
 *     <font color="blue">V1.9</font>
 *     - 페이징 출력 관련 함수 추가. (cfFillGridHeaderPeriod, cfGRadioChg, cfPrintPopupSetting)
 *     - onkeydown 이벤트에서 cfValidateMaxByteLength 함수 호출시 return문은 기술해주지 않아도 됨.
 *     - cfIsIn 함수 추가
 *     - MSG_CONFIRM_UPDATE --> MSG_NOTIFY_NOT_UPDATED 로 변경.
 *     - 페이지 전환시에 변경사항이 저장되지 않았을 경우 confirm box 띄우는 feature 추가.
 *     - 공통 메시지 추가(MSG_CONFIRM_CONTINUE_WITHOUT_APPLY_CHANGE)
 *     - Grid Style 적용시 성능개선. CrossTab, Suppress 시에도 적용되도록 수정.
 *     - String 객체에 insert 메소드 추가.
 *     - cfFillGridNoDataMsg 함수의 파라미터 변경 및 Grid의 width를 style로 지정했을 경우 발생하는 버그 수정.
 *     - modal dialog box 에서 페이징을 사용할 경우 페이지 링크 클릭시 새창뜨는 버그 수정.
 *     - cfFillGridHeader 함수 변경.
 *     - cfGetPageParameter 함수 추가.
 *     - cfCopyDataSet 함수 실행시에 target DataSet의 속성값(예, DataId)이 지워지는 버그 해결.
 *
 *     <font color="blue">V1.8</font>
 *     - 팝업창에서 화면명 영역 중 도움말 항목이 깨지는 버그 수정
 *
 *     <font color="blue">V1.7</font>
 *     - cfValidateMaxByteLength 함수 추가.
 *
 *     <font color="blue">V1.6</font>
 *     - cfOpen 함수 추가.
 *     - 유효성 검사항목중에서 byteLength, minByteLength, maxLength, maxByteLength 추가.
 *     - Grid 유효성 검사시에 key 값에 대한 중복체크 추가. cfValidate 함수 참조.
 *     - String.simpleReplace 함수 추가.
 *     - String.trimAll 함수 추가.
 *     - String.advancedSplit 함수 추가.
 *     - String.ignoreSplit 함수 삭제.
 *     - cfGetCurrentDate 함수호출시 서버날짜를 한달이후 날짜로 가져오는 오류 수정.
 *     - Grid에 대한 validation 수행을 위한 Grid의 validExp 값을 명시할 경우 item name을 기술하지 않았을 때는
 *       컬럼명으로 대체하도록 수정.
 *     - Date.before 함수 추가.
 *     - Date.after 함수 추가.
 *     - cfNaviPageIn, cfNaviPageOut, cfIsNaviPage 함수 추가. (기존의 cfNaviPageInto와 cfNaviPageLoad 함수는 삭제됨)
 *     - coParameterMap 오브젝트 추가.
 *
 *     <font color="blue">V1.5</font>
 *     - paging 사용시 Grid sorting이 일어날 경우 오류 수정.
 *     - 숫자값에 대한 validation 오류 수정.
 *     - cfCopyDataSet에 features 파라미터 추가.
 *     - cfEnable 함수 추가.
 *     - cfStyleGrid에 features 파라미터 추가.
 *     - cfGetPageInfo 함수 추가.
 *
 *     <font color="blue">V1.4</font>
 *     - filter 유효성 검사 추가.
 *     - String.ignoreSplit 함수 추가.
 *
 *     <font color="blue">V1.3</font>
 *     - cfFillGridHeader 모양 변경 및 페이지이동버튼 삭제.
 *     - cfGetElementType 함수 추가.
 *     - cfDisable 함수 추가.
 *     - cfStyleTab 함수 추가.
 *     - cfStyleGrid 함수 추가.
 *     - cfFillGridNoDataMsg 함수 추가.
 *     - cfGetCurrentDate 함수 추가.
 *     - validation 관련 함수 및 validation 사용방법 수정.
 *     - cfIsNull 함수 추가.
 *     - cfIsEnterKey 함수 추가.
 *     - cfCopyDataSetHeader 함수 추가.
 *     - cfCopyDataSet 함수 추가.
 *
 *     <font color="blue">V1.2</font>
 *     - cfDelGridRows -> cfDeleteGridRows 로 함수명 변경.
 *     - cfSelectAllGridRows 함수 추가.
 *     - 공통메세지 변경.
 *     - cfFillGridHeader 파라미터 변경.
 *     - cfBuildBodyTitle 함수 변경.
 *
 *     <font color="blue">V1.1</font>
 *     - cfDigitalNumber 함수 추가.
 *     - cfNaviPageInto  함수 추가.
 *     - cfNaviPageLoad 함수 추가.
 *     - cfBuildBodyTitle 함수에 width 파라미터 추가. 화면 사이즈에 맞게 여백표시하는 부분 추가. (차후 삭제예정)
 * </pre>
 */

/** 이 부분은 document로 generate되지 않습니다.
 * @JScript 참고자료
 * - isNaN : 다음은 모두 숫자로 본다. - "001", "0", "", null
 * - substr(index[, length]) -> index부터 끝까지 혹은 length갯수만큼.
 * - substring(start, end)  -> start index부터 end index전까지의 string
 * Date 오브젝트 생성자들 - dateObj = new Date()
 *                        - dateObj = new Date(dateVal)
 *                        - dateObj = new Date(year, month, date[, hours[, minutes[, seconds[,ms]]]])
 */


//----------------------------- 1. 공통 메세지 영역입니다. -------------------------------//
//------11월 15일 이후 삭제 되며 이후 다음단락에 정의된 메시지 상수를 이용한다.----------------//

// common message
var MSG_SUCCESS_LOGIN = "@님 안녕하세요?\n11월/15일 이후 삭제됩니다.\n'MSG_COM_INF_005'를 사용하여 사용하여 주십시오";
var MSG_CONFIRM_SAVE = "저장하시겠습니까?\n11월/15일 이후 삭제됩니다.\n'MSG_COM_CRM_001'를 사용하여 주십시오";
var MSG_COMPLETE_SAVE = "성공적으로 저장하였습니다.\n11월/15일 이후 삭제됩니다.\n'MSG_COM_INF_001'를 사용하여 주십시오";
var MSG_CONFIRM_REGIST = "등록하시겠습니까?\n11월/15일 이후 삭제됩니다.\n'MSG_COM_CRM_002를 사용하여 주십시오";
var MSG_COMPLETE_REGIST = "성공적으로 등록하였습니다.\n11월/15일 이후 삭제됩니다.\n'MSG_COM_INF_002'를 사용하여 주십시오";
var MSG_CONFIRM_UPDATE = "수정하시겠습니까?\n11월/15일 이후 삭제됩니다.\n'MSG_COM_CRM_003를 사용하여 주십시오";
var MSG_COMPLETE_UPDATE = "성공적으로 수정하였습니다.\n11월/15일 이후 삭제됩니다.\n'MSG_COM_INF_003'를 사용하여 주십시오";
var MSG_CONFIRM_DELETE = "삭제하시겠습니까?\n11월/15일 이후 삭제됩니다.\n'MSG_COM_CRM_004를 사용하여 주십시오";
var MSG_COMPLETE_DELETE = "성공적으로 삭제하였습니다.\n11월/15일 이후 삭제됩니다.\n'MSG_COM_INF_004'를 사용하여 주십시오";
var MSG_NOTIFY_NOT_UPDATED = "변경된 사항이 없습니다.\n11월/15일 이후 삭제됩니다.\n'MSG_COM_ERR_001'를 사용하여 주십시오";
var MSG_CONFIRM_CONTINUE_WITHOUT_APPLY_CHANGE = "변경사항이 반영되지 않았습니다. 계속 하시겠습니까?\n11월/15일 이후 삭제됩니다.\n'MSG_COM_CRM_005'를 사용하여 사용하여 주십시오";
var MSG_PARAM_TEST        = "전달된 3개의 파라미터는 @, @, @ 입니다.\n11월/15일 이후 삭제됩니다.\n'MSG_COM_INF_006'를 사용하여 사용하여 주십시오";

// validation message
var VMSG_VALID            = "유효합니다.\n11월/15일 이후 삭제됩니다.\n'MSG_COM_INF_007'를 사용하여 사용하여 주십시오";
var VMSG_ITEMNAME         = "@ 은(는) \n11월/15일 이후 삭제됩니다.\n'MSG_COM_ERR_030'를 사용하여 사용하여 주십시오";
var VMSG_GRID             = "@의 @번째 데이터에서 \n11월/15일 이후 삭제됩니다.\n'MSG_COM_ERR_031'를 사용하여 사용하여 주십시오";
var VMSG_ERR_DUPLICATE    = "중복될 수 없습니다.\n11월/15일 이후 삭제됩니다.\n'MSG_COM_ERR_032'를 사용하여 사용하여 주십시오";
var VMSG_ERR_LENGTH       = "@자리수만큼 입력하십시오.\n11월/15일 이후 삭제됩니다.\n'MSG_COM_ERR_005'를 사용하여 주십시오";
var VMSG_ERR_BYTE_LENGTH  = "@자리수만큼 입력하십시오.(한글은 @자리수) \n11월/15일 이후 삭제됩니다.\n'MSG_COM_ERR_027'를 사용하여 사용하여 주십시오";
var VMSG_ERR_MIN_LENGTH   = "@자 이상으로 입력하십시오.\n11월/15일 이후 삭제됩니다.\n'MSG_COM_ERR_011'를 사용하여 주십시오";
var VMSG_ERR_MIN_BYTE_LENGTH   = "@자 이상으로 입력하십시오. (한글은 @자 이상)\n11월/15일 이후 삭제됩니다.\n'MSG_COM_ERR_028'를 사용하여 사용하여 주십시오";
var VMSG_ERR_MAX_LENGTH   = "@자 이하로 입력하십시오.\n11월/15일 이후 삭제됩니다.\n'MSG_COM_ERR_012'를 사용하여 주십시오";
var VMSG_ERR_MAX_BYTE_LENGTH   = "@자 이하로 입력하십시오. (한글은 @자 이하)\n11월/15일 이후 삭제됩니다.\n'MSG_COM_ERR_029'를 사용하여 사용하여 주십시오";
var VMSG_ERR_MIN_NUM      = "@ 이상으로 입력하십시오.\n11월/15일 이후 삭제됩니다.\n'MSG_COM_ERR_013'를 사용하여 주십시오";
var VMSG_ERR_MAX_NUM      = "@ 이하로 입력하십시오.\n11월/15일 이후 삭제됩니다.\n'MSG_COM_ERR_014'를 사용하여 주십시오";
var VMSG_ERR_IN_NUM       = "@부터 @사이로 입력하십시오.\n11월/15일 이후 삭제됩니다.\n'MSG_COM_ERR_006'를 사용하여 주십시오";
var VMSG_ERR_NUMBER       = "숫자만을 입력하십시오.\n11월/15일 이후 삭제됩니다.\n'MSG_COM_ERR_007'를 사용하여 주십시오";
var VMSG_ERR_ALPHA        = "문자만을 입력하십시오.\n11월/15일 이후 삭제됩니다.\n'MSG_COM_ERR_008'를 사용하여 주십시오";
var VMSG_ERR_REQUIRED     = "필수 입력 항목입니다.\n11월/15일 이후 삭제됩니다.\n'MSG_COM_ERR_002'를 사용하여 주십시오";
var VMSG_ERR_SSN          = "유효한 주민등록번호가 아닙니다.\n11월/15일 이후 삭제됩니다.\n'MSG_COM_ERR_016'를 사용하여 주십시오";
var VMSG_ERR_CSN          = "유효한 사업자등록번호가 아닙니다.\n11월/15일 이후 삭제됩니다.\n'MSG_COM_ERR_017'를 사용하여 주십시오";
var VMSG_ERR_FILTER_IN    = "다음 문자만 올 수 있습니다.\n@\n11월/15일 이후 삭제됩니다.\n'MSG_COM_ERR_036'를 사용하여 사용하여 주십시오";
var VMSG_ERR_FILTER_OUT   = "다음 문자가 올 수 없습니다.\n@\n11월/15일 이후 삭제됩니다.\n'MSG_COM_ERR_033'를 사용하여 사용하여 주십시오";
var VMSG_ERR_DATE         = "유효한 날짜가 아닙니다.\n11월/15일 이후 삭제됩니다.\n'MSG_COM_ERR_018'를 사용하여 주십시오";
var VMSG_ERR_EMAIL        = "유효한 이메일 주소가 아닙니다.\n11월/15일 이후 삭제됩니다.\n'MSG_COM_ERR_037'를 사용하여 사용하여 주십시오";
var VMSG_ERR_YEAR         = "년도가 잘못되었습니다.\n11월/15일 이후 삭제됩니다.\n'MSG_COM_ERR_015'를 사용하여 주십시오";
var VMSG_ERR_MONTH        = "월이 잘못되었습니다.\n11월/15일 이후 삭제됩니다.\n'MSG_COM_ERR_019'를 사용하여 주십시오";
var VMSG_ERR_DAY          = "일이 잘못되었습니다.\n11월/15일 이후 삭제됩니다.\n'MSG_COM_ERR_020'를 사용하여 주십시오";
var VMSG_ERR_HOUR         = "시가 잘못되었습니다.\n11월/15일 이후 삭제됩니다.\n'MSG_COM_ERR_021'를 사용하여 주십시오";
var VMSG_ERR_MINUTE       = "분이 잘못되었습니다.\n11월/15일 이후 삭제됩니다.\n'MSG_COM_ERR_022'를 사용하여 주십시오";
var VMSG_ERR_SECOND       = "초가 잘못되었습니다.\n11월/15일 이후 삭제됩니다.\n'MSG_COM_ERR_023'를 사용하여 주십시오";
var VMSG_ERR_MIN_DATE     = "@년 @월 @일 이후이어야 합니다.\n11월/15일 이후 삭제됩니다.\n'MSG_COM_ERR_025'를 사용하여 주십시오";
var VMSG_ERR_MAX_DATE     = "@년 @월 @일 이전이어야 합니다.\n11월/15일 이후 삭제됩니다.\n'MSG_COM_ERR_024'를 사용하여 주십시오";
var VMSG_ERR_FORMAT       = "'@' 형식이어야 합니다.\n" +
                            "  - # : 문자 혹은 숫자\n" +
                            "  - h, H : 한글(H는 공백포함)\n" +
                            "  - A, Z : 문자(Z는 공백포함)\n" +
                            "  - 0, 9 : 숫자(9는 공백포함)\n11월/15일 이후 삭제됩니다.\n'MSG_COM_ERR_026'를 사용하여 주십시오";

var PMSG_ERR_PAGE         = "페이지 설정이 잘못되었습니다.\n11월/15일 이후 삭제됩니다.\n'MSG_COM_ERR_034'를 사용하여 사용하여 주십시오";
var PMSG_ERR_MAXPAGE      = "@페이지 이상은 출력할 수 없습니다\n11월/15일 이후 삭제됩니다.\n'MSG_COM_ERR_035'를 사용하여 주십시오";

//----------------------------- 새로 적용되어야 할 공통 메시지 영역입니다. ------------------------------//

var MSG_COM_INF_001   = "성공적으로 저장하였습니다.";
var MSG_COM_INF_002   = "성공적으로 등록하였습니다.";
var MSG_COM_INF_003   = "성공적으로 수정하였습니다.";
var MSG_COM_INF_004   = "성공적으로 삭제하였습니다.";
var MSG_COM_INF_005   = "@님 안녕하세요?";
var MSG_COM_INF_008   =  "관리자에게 문의하십시오.";
var MSG_COM_INF_009   =  "성공적으로 출력되었습니다.";
var MSG_COM_INF_010   =  "@을(를) 성공적으로 저장하였습니다.";
var MSG_COM_INF_011   =  "@이(가) 삭제되었습니다.";
var MSG_COM_INF_012   =  "@을(를) 성공적으로 생성하였습니다.";
var MSG_COM_INF_013   =  "처리가 취소되었습니다.";
var MSG_COM_INF_007   =  "유효합니다.";
var MSG_COM_INF_015   =  "유효한 @입니다.";
var MSG_COM_CRM_001   = "저장하시겠습니까?";
var MSG_COM_CRM_002   = "등록하시겠습니까?";
var MSG_COM_CRM_003   = "수정하시겠습니까?";
var MSG_COM_CRM_004   = "삭제하시겠습니까?";
var MSG_COM_CRM_005   = "변경사항이 반영되지 않았습니다. 계속 하시겠습니까?";
var MSG_COM_CRM_006   =  "이미 존재하는 @ 입니다. 추가하시겠습니까?";
var MSG_COM_CRM_008   =  "@을(를) 삭제하시겠습니까?";
var MSG_COM_CRM_009   =  "@을(를) 생성하시겠습니까?";
var MSG_COM_CRM_010   =  "@을(를) 적용하시겠습니까?";
var MSG_COM_CRM_011   =  "취소하시겠습니까?";
var MSG_COM_CRM_013   =  "즉시 승인하시겠습니까?";
var MSG_COM_ERR_001   = "@은(는) 변경된 사항이 없습니다.";
var MSG_COM_ERR_002   = "@은(는) 필수 입력 항목입니다.";
var MSG_COM_ERR_003   = "해당되는 자료가 존재하지 않습니다.";
var MSG_COM_ERR_004   = "@은(는) 공백없이 입력하십시오.";
var MSG_COM_ERR_005   = "@은(는) @자리수만큼 입력하십시오.";
var MSG_COM_ERR_006   = "@은(는) @부터 @사이로 입력하십시오.";
var MSG_COM_ERR_007   = "@은(는) 숫자만을 입력하십시오.";
var MSG_COM_ERR_008   = "@은(는) 문자만을 입력하십시오.";
var MSG_COM_ERR_009   = "@은(는) 숫자와 문자만을 입력하십시오.(공백제외)";
var MSG_COM_ERR_010   = "@은(는) 숫자와 문자만을 입력하십시오.(공백포함)";
var MSG_COM_ERR_011   = "@은(는) @자 이상으로 입력하십시오.";
var MSG_COM_ERR_012   = "@은(는) @자 이하로 입력하십시오.";
var MSG_COM_ERR_013   = "@은(는) @ 이상으로 입력하십시오.";
var MSG_COM_ERR_014   = "@은(는) @ 이하로 입력하십시오.";
var MSG_COM_ERR_015   = "@은(는) 년도가 잘못되었습니다.";
var MSG_COM_ERR_016   = "@은(는) 유효한 주민등록번호가 아닙니다.";
var MSG_COM_ERR_017   = "@은(는) 유효한 사업자등록번호가 아닙니다.";
var MSG_COM_ERR_018   = "@은(는) 유효한 날짜가 아닙니다.";
var MSG_COM_ERR_019   = "@은(는) 월이 잘못되었습니다.";
var MSG_COM_ERR_020   = "@은(는) 일이 잘못되었습니다.";
var MSG_COM_ERR_021   = "@은(는) 시가 잘못되었습니다.";
var MSG_COM_ERR_022   = "@은(는) 분이 잘못되었습니다.";
var MSG_COM_ERR_023   = "@은(는) 초가 잘못되었습니다.";
var MSG_COM_ERR_025   = "@은(는) @년 @월 @일 이후이어야 합니다.";
var MSG_COM_ERR_024   = "@은(는) @년 @월 @일 이전이어야 합니다.";
var MSG_COM_ERR_026   = "@은(는) '@' 형식이어야 합니다.\n" +
                            "  - # : 문자 혹은 숫자\n" +
                            "  - h, H : 한글(H는 공백포함)\n" +
                            "  - A, Z : 문자(Z는 공백포함)\n" +
                            "  - 0, 9 : 숫자(9는 공백포함)";
var MSG_COM_ERR_027   =  "@은(는) @자리수만큼 입력하십시오. (한글은 @자리수)";
var MSG_COM_ERR_028   =  "@은(는) @자 이상으로 입력하십시오. (한글은 @자 이상)";
var MSG_COM_ERR_029   =  "@은(는) @자 이하로 입력하십시오. (한글은 @자 이하)";
var MSG_COM_ERR_030   =  "@은(는) ";
var MSG_COM_ERR_031   =  "@의 @번째 데이터에서 ";
var MSG_COM_ERR_032   =  "@은(는) 중복될 수 없습니다.";
var MSG_COM_ERR_033   =  "@은(는) 다음 문자가 올 수 없습니다.\n@";
var MSG_COM_ERR_034   =  "페이지 설정이 잘못되었습니다.";
var MSG_COM_ERR_035   =  "@페이지 이상은 출력할 수 없습니다";
var MSG_COM_ERR_036   =  "@은(는) 다음 문자만 올 수 있습니다.\n@";
var MSG_COM_ERR_037   =  "@은(는) 유효한 이메일 주소가 아닙니다.";
var MSG_COM_ERR_038   =  "유효한 @가 아닙니다."
var MSG_COM_ERR_039   =  "시작일자를 종료일자 이전으로 선택[입력]하여 주십시오.";
var MSG_COM_ERR_040   =  "패스워드가 일치하지 않습니다.";
var MSG_COM_ERR_041   =  "@은(는) @할 수 없습니다.";
var MSG_COM_ERR_042   =  "@은(는) 변경된 사항이 있습니다. \n변경사항을 저장 후 @을(를) 수행하십시오.";
var MSG_COM_ERR_043	  =  "유효하지 않는 @ 입니다.\n다시 입력하여주십시요";
var MSG_COM_ERR_045   =  "시작범위는 종료범위보다 작아야 합니다. :@";
var MSG_COM_ERR_046   =  "존재하지 않는 @입니다.";
var MSG_COM_ERR_047   =  "오류가 발생하였습니다.\n관리자에게 문의하십시오.";
var MSG_COM_ERR_048   =  "@은(는) @보다 작아야 합니다.";
var MSG_COM_ERR_049   =  "@이(가) 존재하지 않습니다.";
var MSG_COM_ERR_050   =  "오류가 발생하였습니다.\n처음부터 다시 시작하여 주십시오.";
var MSG_COM_ERR_051   =  "@을(를) 실패하였습니다.";
var MSG_COM_ERR_052   =  "해당조건의 @이(가) 존재하지 않습니다.";
var MSG_COM_ERR_053   =  "@이(가) 누락되었습니다.";
var MSG_COM_ERR_054   =  "@ 생성을 실패하였습니다.";
var MSG_COM_ERR_055   =  "@을(를) 확인하여 주십시오.";
var MSG_COM_ERR_056   =  "선택된 @이(가) 없습니다.";
var MSG_COM_ERR_057   =  "@은(는) @ 보다 큰 값으로 입력하십시오.";
var MSG_COM_ERR_058   =  "시작시간을 종료시간 이전으로 선택[입력]하여 주십시오.";
var MSG_COM_ERR_059   =  "@은(는) 정수부를 @자 이하로 입력하십시오.";
var MSG_COM_ERR_060   =  "@은(는) 소수부를 @자 이하로 입력하십시오."
var MSG_COM_ERR_061   =  "해당 항목의 값이 존재 합니다.\n다시 확인하시고 추가 하십시오."
var MSG_COM_ERR_062   =  "@은(는) 유효한 운전면허번호가 아닙니다.\n 사용하시겠습니까?";
var MSG_COM_ERR_067   =  "@은(는) 중복된 운전면허번호 입니다.\n 사용하시겠습니까?";
var MSG_COM_ERR_063   =  "실패하였습니다."
var MSG_COM_ERR_064   =  "성공적으로 처리되었습니다."
var MSG_COM_ERR_065   =  "@은(는) 유효한 주민등록번호가 아닙니다.\n 사용하시겠습니까?";
var MSG_COM_ERR_066   =  "@은(는) 중복된 주민등록번호 입니다.\n 사용하시겠습니까?";
var MSG_COM_WRN_001   =  "저장할 데이터가 존재하지 않습니다.\n먼저 @검색을 하십시오.";
var MSG_COM_WRN_002   =  "조회결과가 존재하지 않습니다.";
var MSG_COM_WRN_003   =  "@을(를) 입력하십시오.";
var MSG_COM_WRN_004   =  "삭제할 @이(가) 존재하지 않습니다.";
var MSG_COM_WRN_005   =  "'+' 버튼을 누른 후 입력하십시오.";
var MSG_COM_WRN_006   =  "'+'버튼을 누르신 후 @을(를) 입력하십시오.";
var MSG_COM_WRN_007   =  "@을(를) 선택하십시오.";
var MSG_COM_WRN_008   =  "검색한 데이터가 존재하지 않습니다.\n먼저 @검색을 하십시오.";
var MSG_COM_WRN_009   =  "출력할 @이(가) 없습니다.";
var MSG_COM_WRN_010   =  "@ 버튼을 이용하십시오.";
var MSG_COM_WRN_011   =  "이미 존재하는 @입니다.";
var MSG_COM_WRN_012   =  "@이(가) 반영되지 않았습니다.";
var MSG_COM_WRN_013	= "@ 은(는) @이(가) 없습니다.";
var HR_WARNING_01	=  "기본사항이 입력되지 않았습니다.\n먼저 기본사항을 입력해 주세요";
var HR_WARNING_02	=  "@은(는) '@' 형식이어야 합니다.\n'@'";
var HR_WARNING_03	=  "@ 버튼을 누른후 실행해 주세요";
var HR_WARNING_04	=  MSG_COM_ERR_002 + " @번째 "+MSG_COM_WRN_003;
var HR_WARNING_05	= "@년도 @회차에 @은(는) 이미 등록되어 있습니다.";
var HR_WARNING_06	= "검색결과가 없습니다.";
var HR_WARNING_07	= "@" +  MSG_COM_CRM_001;
var HR_WARNING_08	= "@이 입력되지 않았습니다.기본사항으로 입력하시겠습니까?";
var HR_WARNING_09	= "'@' 의 동일한 데이터가 존재합니다. 계속하시겠습니까?";
var HR_WARNING_10	= "'@'의 데이터가 성공적으로 처리되었습니다.";
var HR_WARNING_11	= "'@' 번째에 동일한 데이터가 존재합니다.";
var HR_WARNING_12	= "'@' 는 존재하지 않는 주민등록번호입니다.";
var HR_WARNING_13	=	"@ 과	@(이)가 기간이 명확하지 않습니다.";
var HR_WARNING_14	=	"먼저 데이터를 입력할 사원을 조회하십시오";
var HR_WARNING_15	=	"변경된 사항이 없습니다.";

var MSG_COM_GAUCE_50000 	 = 		 "성공하였습니다.";
var MSG_COM_GAUCE_50001    =     "실패하였습니다.";
var MSG_COM_GAUCE_50002    =     "해당 property값이 유효하지 않습니다. (property명:CodeColumn )	";
var MSG_COM_GAUCE_50003    =     "해당 property값이 유효하지 않습니다. (property명:DataColumn )	";
var MSG_COM_GAUCE_50004    =     "Combo Dataset에서 column 을 찾지 못했습니다.	";
var MSG_COM_GAUCE_50005    =     "해당 property값이 유효하지 않습니다. (property명:CodeCColumn )	";
var MSG_COM_GAUCE_50006    =     "해당 property값이 유효하지 않습니다. (property명:DataCColumn )	";
var MSG_COM_GAUCE_50009    =     "해당 Code value로의 setting에 실패하였습니다.	";
var MSG_COM_GAUCE_50010    =     "해당 Data value로의 setting에 실패하였습니다.	";
var MSG_COM_GAUCE_50007		 =	 	 "해당 property값이 유효하지 않습니다. (property명:DataID )	";
var MSG_COM_GAUCE_50008    =     "해당 property값이 유효하지 않습니다. (property명:ComboDataID )	";
var MSG_COM_GAUCE_50007    =     "해당 property값이 유효하지 않습니다. ";
var MSG_COM_GAUCE_50062    =     "해당 property값이 유효하지 않습니다. (property명:xValueColumn )	";
var MSG_COM_GAUCE_50063    =     "해당 property값이 유효하지 않습니다. (property명:yValueColumns )	";
var MSG_COM_GAUCE_50011    =     "Data를 얻는데 실패하였습니다.	";
var MSG_COM_GAUCE_50012    =     "데이타 다운로드중 오류가 발생하였습니다.	";
var MSG_COM_GAUCE_50013    =     "자원이 부족하여 처리할수 없습니다. 다른 응용 프로그램을 종료후 다시 시도해 보십시요.	";
var MSG_COM_GAUCE_50014    =     "데이타 로딩시 포멧에 오류가 있습니다.	";
var MSG_COM_GAUCE_50015    =     "서버에서 다음과 같은 메세지가 전송되었습니다.	";
var MSG_COM_GAUCE_50016    =     "데이타의 이전 포멧과 현재포맷이 다름니다.	";
var MSG_COM_GAUCE_50017    =     "데이타 로딩시 다음과 같은 에러가 발생되었습니다.	";
var MSG_COM_GAUCE_50018    =     "이 컬럼은 NULL값을 갖을수 없습니다.	";
var MSG_COM_GAUCE_50019    =     "key column으로 설정된 컬럼은 다른row와 같은 값을 갖지 못합니다. 다른 값을 설정해 주십시요.";
var MSG_COM_GAUCE_50020    =     "filter된 row값들 중 key column으로 설정된 컬럼은 다른 row와 같은 값을 갖지 못합니다. 다른 값을 설정해 주십시요.	";
var MSG_COM_GAUCE_50021    =     "현재의 dataset의 상태가 읽기 전용입니다..const column 값을 변경시킬수 없습니다.	";
var MSG_COM_GAUCE_50022    =     "입력된 column index가 전체 column 갯수 영역을 벗어났습니다. const column 값을 변경시킬수 없습니다.	";
var MSG_COM_GAUCE_50023    =     "const column 값을 변경시킬 수 없습니다.	";
var MSG_COM_GAUCE_50023    =     "const column 값을 변경시킬 수 없습니다.	";
var MSG_COM_GAUCE_50023    =     "const column 값을 변경시킬 수 없습니다.	";
var MSG_COM_GAUCE_50024    =     "현재의 dataset 의 상태가 읽기 전용입니다. column 값을 변경시킬수 없습니다.	";
var MSG_COM_GAUCE_50025    =     "입력된 Row Index가 전체 Row 갯수 영역을 벗어났습니다.  column 값을 변경시킬수 없습니다.	";
var MSG_COM_GAUCE_50026    =     "입력된 column index가 전체 column 갯수 영역을 벗어났습니다.  column 값을 변경시킬수 없습니다.";
var MSG_COM_GAUCE_50027    =     "이 컬럼은 상수컬럼이 아닙니다.  해당 Method of Property를 사용할수 없습니다. 	";
var MSG_COM_GAUCE_50028    =     "update모드에서는 key column을 수정할수 없습니다.  column 값을 변경시킬수 없습니다.	";
var MSG_COM_GAUCE_50029    =     "column 값을 변경시킬 수 없습니다.	";
var MSG_COM_GAUCE_50030    =     "해당하는 ColumnID를 찾을 수 없습니다.  정확한 ColumnID인지 확인하십시오.	";
var MSG_COM_GAUCE_50031    =     "프린터 설정에 오류가 있습니다.. 	";
var MSG_COM_GAUCE_50032    =     "report format property값에 오류가 있습니다.   Format값을 확인 해보시기 바랍니다.	";
var MSG_COM_GAUCE_50033    =     "Suppress Column string에서 해당 column을 찾을수 없습니다.	";
var MSG_COM_GAUCE_50064    =     "해당 property값이 유효하지 않습니다. (property명:Format )	";
var MSG_COM_GAUCE_50034    =     "Report Format Property값에 예약된 tag를 사용하지 않았습니다.	";
var MSG_COM_GAUCE_50035    =     "Report Format Property값에 tag의 짝이 맞지 않습니다.	";
var MSG_COM_GAUCE_50036    =     "Format script에 오류가 다음과 같은 오류가 있습니다.  script를 확인해 보십시요.	";
var MSG_COM_GAUCE_50037    =     "div tag를 찾는데 실패하였습니다.	";
var MSG_COM_GAUCE_50038    =     "Server IP property값이 입력되지 않았습니다.	";
var MSG_COM_GAUCE_50039    =     "Action property값이 입력되지 않았습니다.	";
var MSG_COM_GAUCE_50040    =     "KeyName property값이 입력되지 않았습니다.	";
var MSG_COM_GAUCE_50041    =     "KeyValue property값이 입력되지 않았습니다.";
var MSG_COM_GAUCE_50042    =     "KeyValue property format에서 오류가 있습니다.	";
var MSG_COM_GAUCE_50043    =     "WinInet API 오류.	";
var MSG_COM_GAUCE_50044    =     "IDispatch 호출에서 시스템오류가 발생하였습니다.	";
var MSG_COM_GAUCE_50045    =     "Server에서 오류메세지를 다음과 같이 보내왔습니다.	";
var MSG_COM_GAUCE_50046    =     "윈도우 핸들에 오류가 있습니다.	";
var MSG_COM_GAUCE_50047    =     "Font정보를 얻는데 실패하였습니다.	";
var MSG_COM_GAUCE_50048    =     "Background Color정보를 얻는데 실패하였습니다.	";
var MSG_COM_GAUCE_50049    =     "COLOR 정보를 얻는데 실패하였습니다.	";
var MSG_COM_GAUCE_50050    =     "Image List 만드는데 실패하였습니다.	";
var MSG_COM_GAUCE_50051    =     "DataSet의 Data의 총 갯수 정보를 얻는데 실패하였습니다.	";
var MSG_COM_GAUCE_50052    =     "변경된 자료가 없습니다.	";
var MSG_COM_GAUCE_50053    =     "DataColumn Property값이 입력되지 않았습니다.	";
var MSG_COM_GAUCE_50054    =     "CodeColumn Property값이 입력되지 않았습니다.	";
var MSG_COM_GAUCE_50065    =     "데이타버퍼를 할당하는데 실패하였습니다.	";
var MSG_COM_GAUCE_50055    =     "경로에 오류가 발생했습니다.	";
var MSG_COM_GAUCE_50056    =     "정상적으로 저장되었습니다.	";
var MSG_COM_GAUCE_50057    =     "page Size가 출력될 각band영역 보다 작습니다.	";
var MSG_COM_GAUCE_50058    =     "Index가 범위를 초과하였습니다.	";
var MSG_COM_GAUCE_50059    =     "DataRColumn Property값이 입력되지 않았습니다.	";
var MSG_COM_GAUCE_50060    =     "CodeRColumn Property값이 입력되지 않았습니다.	";
var MSG_COM_GAUCE_50062    =     "해당 property값이 유효하지 않습니다. (property명:RadioDataID )	";
var MSG_COM_GAUCE_50061    =     "LZW type의 이미지는 지원하지 않습니다.	";
var MSG_COM_GAUCE_50073    =     "연결 시간이 초과되었습니다.	";
var MSG_COM_GAUCE_50070    =     "잘못된 이미지 URL입니다.";
var MSG_COM_GAUCE_50071    =     "이미지 메모리 파일 로드에 실패하였습니다.";
var MSG_COM_GAUCE_50072    =     "Lead PaintDC를 얻어오는데 실패하였습니다.";
var MSG_COM_GAUCE_501      =     "잘라내기\tCtrl+X";
var MSG_COM_GAUCE_502      =     "복사하기\tCtrl+C";
var MSG_COM_GAUCE_503      =     "붙여넣기\tCtrl+V";
var MSG_COM_GAUCE_504      =     "삭제하기\tDel";
var MSG_COM_GAUCE_50069    =     "모두선택\tCtrl+A";
var MSG_COM_GAUCE_901      =     "계 ";
var MSG_COM_GAUCE_902      =     "합계 ";
var MSG_COM_GAUCE_903      =     "굴림체";
var MSG_COM_GAUCE_601      =     "취소 .......";
var MSG_COM_GAUCE_602      =     "남은 이미지수(%d).....";
var MSG_COM_GAUCE_606      =     "이미지 받는중.....";
var MSG_COM_GAUCE_608      =     "출력중 .....";
var MSG_COM_GAUCE_603      =     "총 페이지 :";
var MSG_COM_GAUCE_604      =     "출력셋팅";
var MSG_COM_GAUCE_605      =     "출력";
var MSG_COM_GAUCE_607      =     "종료";
var MSG_COM_GAUCE_701      =     "프린터를 초기화 할 수 없습니다.";
var MSG_COM_GAUCE_702      =     "페이지를 인쇄할 수 없습니다.";
var MSG_COM_GAUCE_609      =     "인쇄 작업을 시작할 수 없습니다.";
var MSG_COM_GAUCE_50067    =     "해당 property값이 유효하지 않습니다. (property명:ImgDColumn )	";
var MSG_COM_GAUCE_50066    =     "해당 property값이 유효하지 않습니다. (property명:ImgCColumn )	";
var MSG_COM_GAUCE_50068    =     "해당 property값이 유효하지 않습니다. (property명:ImgOColumn )	";
var MSG_COM_GAUCE_51000    =     "Tr의 Post 메소드에서 세션키 생성에 실패했습니다.";
var MSG_COM_GAUCE_51010    =     "Tr의 Parameters속성값을 암호화하는데 실패했습니다.";
var MSG_COM_GAUCE_52000    =     "SeriesType이 맞지 않습니다.";
var MSG_COM_GAUCE_52001    =     "지원되지 않는 Category거나 Property입니다.";
var MSG_COM_GAUCE_50074    =     "사용자 정의 에러코드는 NULL이 될수 없습니다.";
var MSG_COM_GAUCE_53900    =     "패킷에 Magic ID가 없습니다.";
var MSG_COM_GAUCE_53903    =     "패킷 헤더에서 Magic ID를 확인할 수 없습니다.";
var MSG_COM_GAUCE_53905    =     "패킷에 Magic 문자열이 없습니다.";
var MSG_COM_GAUCE_53906    =     "패킷 헤더에서 Format Type을 확인할 수 없습니다.";
var MSG_COM_GAUCE_53910    =     "패킷 헤더에서 Data Size를 확인할 수 없습니다..";
var MSG_COM_GAUCE_53911    =     "패킷에서 데이터를 읽을 수 없습니다.";
var MSG_COM_GAUCE_53990    =     "컨트롤 패킷에 형식 오류가 있습니다.";
var MSG_COM_GAUCE_53991    =     "에러 패킷에 형식 오류가 있습니다.";
var MSG_COM_GAUCE_53930    =     "컨트롤 패킷을 찾을 수 없습니다.";
var MSG_COM_GAUCE_53950    =     "서버에서 전송한 데이터를 저장할 데이터셋을 찾을 수 없습니다.";
var MSG_COM_GAUCE_53951    =     "클라이언트에서 기대하는 데이터셋 리스트와 서버에서 보내온 데이터셋 리스트가 다릅니다.";
var MSG_COM_GAUCE_53952    =     "압축된 데이터를 풀지 못했습니다.";
var MSG_COM_GAUCE_53992    =     "서버 에러 메시지를 처리하지 못했습니다.";

//----------------------------- 2. 공통 스크립트 영역입니다. -----------------------------//
// Global 변수선언
var GLB_MONTH_IN_YEAR       = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
var GLB_SHORT_MONTH_IN_YEAR = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
var GLB_DAY_IN_WEEK         = ["Sunday", "Monday", "Tuesday", "Wednesday","Thursday", "Friday", "Saturday"];
var GLB_SHORT_DAY_IN_WEEK   = ["Sun", "Mon", "Tue", "Wed","Thu", "Fri", "Sat"];
var GLB_DAYS_IN_MONTH       = [31,28,31,30,31,30,31,31,30,31,30,31];

var GLB_URL_COMMON_PAGE     = "";  // common 디렉토리의 URL ( 절대 PATH ROOT )

  if ( checkServerDomain() ) {
   GLB_URL_COMMON_PAGE= "./common/"; // 서버 전체 웹모드 일때
  } else {
   //GLB_URL_COMMON_PAGE= "c:/eKPLS/common/"; //  부분웹 모드 일때
   GLB_URL_COMMON_PAGE= "G:/hun122_Template/0001/common/"; //  부분웹 모드 일때
  }

var GLB_REPORT_MAXPAGE      = 100000000;  // 출력가능한 최대 페이지 수
var GLB_PAGE_PARAMS         = new coMap();
var GLB_FRAME_MAIN          = top.MainFrame;
var GLB_FRAME_MAIN_MENU     = (top.MainFrame == null) ? null : top.MainFrame.MenuFrame;
var GLB_FRAME_MAIN_BODY     = (top.MainFrame == null) ? null : top.MainFrame.BodyFrame;
var GLB_FRAME_SUB_BODY      = (GLB_FRAME_MAIN_BODY == null) ? null : GLB_FRAME_MAIN_BODY.SubBodyFrame;
var GLB_FRAME_MAIN_TAIL     = (top.MainFrame == null) ? null : top.MainFrame.TailFrame;
var GLB_FRAME_MAIN_NAVI     = (top.MainFrame == null) ? null : top.MainFrame.NaviFrame;
var GLB_FRAME_HIDDEN        = top.HiddenFrame;
var GLB_CALENDAR            = new Object();

/**
 * @type   : prototype_function
 * @access : public
 * @desc   : 자바스크립트의 내장 객체인 String 객체에 simpleReplace 메소드를 추가한다. simpleReplace 메소드는
 *           스트링 내에 있는 특정 스트링을 다른 스트링으로 모두 변환한다. String 객체의 replace 메소드와 동일한
 *           기능을 하지만 간단한 스트링의 치환시에 보다 유용하게 사용할 수 있다.
 * <pre>
 *     var str = "abcde"
 *     str = str.simpleReplace("cd", "xx");
 * </pre>
 * 위의 예에서 str는 "abxxe"가 된다.
 * @sig    : oldStr, newStr
 * @param  : oldStr required 바뀌어야 될 기존의 스트링
 * @param  : newStr required 바뀌어질 새로운 스트링
 * @return : replaced String.
 * @author : GAUCE
 */
String.prototype.simpleReplace = function(oldStr, newStr) {
	var rStr = oldStr;

	rStr = rStr.replace(/\\/g, "\\\\");
	rStr = rStr.replace(/\^/g, "\\^");
	rStr = rStr.replace(/\$/g, "\\$");
	rStr = rStr.replace(/\*/g, "\\*");
	rStr = rStr.replace(/\+/g, "\\+");
	rStr = rStr.replace(/\?/g, "\\?");
	rStr = rStr.replace(/\./g, "\\.");
	rStr = rStr.replace(/\(/g, "\\(");
	rStr = rStr.replace(/\)/g, "\\)");
	rStr = rStr.replace(/\|/g, "\\|");
	rStr = rStr.replace(/\,/g, "\\,");
	rStr = rStr.replace(/\{/g, "\\{");
	rStr = rStr.replace(/\}/g, "\\}");
	rStr = rStr.replace(/\[/g, "\\[");
	rStr = rStr.replace(/\]/g, "\\]");
	rStr = rStr.replace(/\-/g, "\\-");

  	var re = new RegExp(rStr, "g");
    return this.replace(re, newStr);
}

// alert("abcde\.()-fgh$$?J+".simpleReplace("\\", ""));

/**
 * @type   : prototype_function
 * @access : public
 * @desc   : 자바스크립트의 내장 객체인 String 객체에 trim 메소드를 추가한다. trim 메소드는 스트링의 앞과 뒤에
 *           있는 white space 를 제거한다.
 * <pre>
 *     var str = " abcde "
 *     str = str.trim();
 * </pre>
 * 위의 예에서 str는 "abede"가 된다.
 * @return : trimed String.
 * @author : GAUCE
 */
String.prototype.trim = function() {
    return this.replace(/(^\s*)|(\s*$)/g, "");
}

/**
 * @type   : prototype_function
* @access : public
 * @desc   : 자바스크립트의 내장 객체인 String 객체에 trimAll 메소드를 추가한다. trim 메소드는 스트링 내에
 *           있는 white space 를 모두 제거한다.
 * <pre>
 *     var str = " abc de "
 *     str = str.trimAll();
 * </pre>
 * 위의 예에서 str는 "abcde"가 된다.
 * @return : trimed String.
 * @author : GAUCE
 */
String.prototype.trimAll = function() {
    return this.replace(/\s*/g, "");
}

// alert(" a b  d ".trimAll());

/**
 * @type   : prototype_function
 * @access : public
 * @desc   : 자바스크립트의 내장 객체인 String 객체에 cut 메소드를 추가한다. cut 메소드는 스트링의 특정 영역을
 *           잘라낸다.
 * <pre>
 *     var str = "abcde"
 *     str = str.cut(2, 2);
 * </pre>
 * 위의 예에서 str는 "abe"가 된다.
 * @sig    : start, length
 * @param  : start  required start index to cut
 * @param  : length required length to cut
 * @return : cutted String.
 * @author : GAUCE
 */

String.prototype.cut = function(start, length) {
    return this.substring(0, start) + this.substr(start + length);
}

/**
 * @type   : prototype_function
 * @access : public
 * @desc   : 자바스크립트의 내장 객체인 String 객체에 insert 메소드를 추가한다. insert 메소드는 스트링의 특정 영역에
 *           주어진 스트링을 삽입한다.
 * <pre>
 *     var str = "abcde"
 *     str = str.insert(3, "xyz");
 * </pre>
 * 위의 예에서 str는 "abcxyzde"가 된다.
 * @sig    : start, length
 * @param  : index required 삽입할 위치. 해당 스트링의 index 바로 앞에 삽입된다. index는 0부터 시작.
 * @param  : str   required 삽입할 스트링.
 * @return : inserted String.
 * @author : GAUCE
 */
String.prototype.insert = function(index, str) {
    return this.substring(0, index) + str + this.substr(index);
}

/**
 * @type   : prototype_function
 * @access : public
 * @desc   : String.split() 와 같지만 여러가지 옵션을 줄 수 있다.
 * <pre>
 *     option list
 *
 *     - i : ignored split
 *         구분자 문자 앞에 "\" 가 붙어있을 때는 구분자로 인식하지 않는다. ('\' 문자를 string으로 표현할 때는 "\\" 로 해야함)
 *             var str = "abc,de\\,fg"
 *             var strArr = str.advancedSplit(",", "i");
 *         위의 예에서 strArr[0]는 "abc", strArr[1]는 "de,fg"가 된다.
 *
 *     - t : trimed split
 *         split 후에 splited string 들을 trim 시킨다.
 *             var str = "abc,  de,fg"
 *             var strArr = str.advancedSplit(",", "t");
 *         위의 예에서 strArr[0]는 "abc", strArr[1]는 "de", strArr[2]는 "fg"가 된다.
 * </pre>
 * 옵션들은 복합적으로 사용될 수 있다.
 * <pre>
 *     var str = "abc,  de\\,fg"
 *     var strArr = str.advancedSplit(",", "it");
 * </pre>
 * 위의 예에서 strArr[0]는 "abc", strArr[1]는 "de,fg"가 된다.
 * @sig    : delim, options
 * @param  : delim   required delimenator
 * @param  : options required 옵션을 나타내는 문자들을 나열한 스트링
 * @return : splited string array.
 * @author : GAUCE
 */
String.prototype.advancedSplit = function(delim, options) {
	if (options == null || options.trim() == "") {
		return this.split(delim);
	}

	var optionI = false;
	var optionT = false;

	options = options.trim().toUpperCase();

	for (var i = 0; i < options.length; i++) {
		if (options.charAt(i) == 'I') {
			optionI = true;
		} else if (options.charAt(i) == 'T') {
			optionT = true;
		}
	}

	var arr = new Array();
	var cnt = 0;
	var startIdx = 0;
	var delimIdx = -1;
	var str = this;
	var temp = 0;

	while ( (delimIdx = (str == null) ?
	         -1 : str.indexOf(delim, startIdx)
	        ) != -1
	      ) {

		if (optionI && str.substr(delimIdx - 1, 2) == '\\' + delim) {
			str = str.cut(delimIdx - 1, 1);
			startIdx = delimIdx;
			continue;
		}

		arr[cnt++] = optionT ? str.substring(0, delimIdx).trim() :
		                       str.substring(0, delimIdx);
		str = str.substr(delimIdx + 1);
		startIdx = 0;
	}

	arr[cnt] = (str == null) ? "" : str;

	return arr;
}

/*
var splitTestStr = "abc  , de\\,  fg , f d".advancedSplit(",", "it");
for (var i = 0; i < splitTestStr.length; i++) {
	alert("'" + splitTestStr[i] + "'");
}
*/

/**
 * @type   : prototype_function
 * @access : public
 * @desc   : 자바스크립트의 내장 객체인 String 객체에 toDate 메소드를 추가한다. toDate 메소드는 날짜를 표현하는
 *           스트링 값을 자바스크립트의 내장 객체인 Date 객체로 변환한다.
 * <pre>
 *     var date = "2002-03-05".toDate("YYYY-MM-DD")
 * </pre>
 * 위의 예에서 date 변수는 실제로 2002년 3월 5일을 표현하는 Date 오브젝트를 가르킨다.
 * @sig    : [pattern]
 * @param  : pattern optional Date를 표현하고 있는 현재의 String을 pattern으로 표현한다. (default : YYYYMMDD)
 * <pre>
 *     # syntex
 *
 *       YYYY : year(4자리)
 *       YY   : year(2자리)
 *       MM   : month in year(number)
 *       DD   : day in month
 *       HH   : hour in day (0~23)
 *       mm   : minute in hour
 *       ss   : second in minute
 *       SS   : millisecond in second
 *
 *     <font color=red>주의)</font> YYYY(YY)는 반드시 있어야 한다. YYYY(YY) 만 사용할 경우는 1월 1일을 기준으로
 *     하고 YYYY와 MM 만사용할 경우는 1일을 기준으로 한다.
 * </pre>
 * @return : 변환된 Date Object.
 * @author : GAUCE
 */
String.prototype.toDate = function(pattern) {
	var index = -1;
	var year;
	var month;
	var day;
	var hour = 0;
	var min  = 0;
	var sec  = 0;
	var ms   = 0;
	var newDate;

	if (pattern == null) {
		pattern = "YYYYMMDD";
	}

	if ((index = pattern.indexOf("YYYY")) == -1 ) {
		index = pattern.indexOf("YY");
		year = "20" + this.substr(index, 2);
	} else {
		year = this.substr(index, 4);
	}

	if ((index = pattern.indexOf("MM")) != -1 ) {
		month = this.substr(index, 2);
	} else {
		month = 1;
	}

	if ((index = pattern.indexOf("DD")) != -1 ) {
		day = this.substr(index, 2);
	} else {
		day = 1;
	}

	if ((index = pattern.indexOf("HH")) != -1 ) {
		hour = this.substr(index, 2);
	}

	if ((index = pattern.indexOf("mm")) != -1 ) {
		min = this.substr(index, 2);
	}

	if ((index = pattern.indexOf("ss")) != -1 ) {
		sec = this.substr(index, 2);
	}

	if ((index = pattern.indexOf("SS")) != -1 ) {
		ms = this.substr(index, 2);
	}

	newDate = new Date(year, month - 1, day, hour, min, sec, ms);
	if (month > 12) {
		newDate.setFullYear(year + 1);
	} else {
		newDate.setFullYear(year);
	}

	return newDate;
}


/**
 * @type   : prototype_function
 * @object : Date
 * @access : public
 * @desc   : 자바스크립트의 내장 객체인 Date 객체에 format 메소드를 추가한다. format 메소드는 Date 객체가 가진 날짜를
 *           지정된 포멧의 스트링으로 변환한다.
 * <pre>
 *     var dateStr = new Date().format("YYYYMMDD");
 *
 *     참고 : Date 오브젝트 생성자들 - dateObj = new Date()
 *                                   - dateObj = new Date(dateVal)
 *                                   - dateObj = new Date(year, month, date[, hours[, minutes[, seconds[,ms]]]])
 * </pre>
 * 위의 예에서 오늘날짜가 2002년 3월 5일이라면 dateStr의 값은 "20020305"가 된다.
 * default pattern은 "YYYYMMDD"이다.
 * @sig    : [pattern]
 * @param  : pattern optional 변환하고자 하는 패턴 스트링. (default : YYYYMMDD)
 * <pre>
 *     # syntex
 *
 *       YYYY : hour in am/pm (1~12)
 *       MM   : month in year(number)
 *       MON  : month in year(text)  예) "January"
 *       mon  : short month in year(text)  예) "Jan"
 *       DD   : day in month
 *       DAY  : day in week  예) "Sunday"
 *       day  : short day in week  예) "Sun"
 *       hh   : hour in am/pm (1~12)
 *       HH   : hour in day (0~23)
 *       mm   : minute in hour
 *       ss   : second in minute
 *       SS   : millisecond in second
 *       a    : am/pm  예) "AM"
 * </pre>
 * @return : Date를 표현하는 변환된 String.
 * @author : GAUCE
 */
Date.prototype.format = function(pattern) {
    var year      = this.getFullYear();
    var month     = this.getMonth() + 1;
    var day       = this.getDate();
    var dayInWeek = this.getDay();
    var hour24    = this.getHours();
    var ampm      = (hour24 < 12) ? "AM" : "PM";
    var hour12    = (hour24 > 12) ? (hour24 - 12) : hour24;
    var min       = this.getMinutes();
    var sec       = this.getSeconds();

    var YYYY = "" + year;
    var YY   = YYYY.substr(2);
    var MM   = (("" + month).length == 1) ? "0" + month : "" + month;
    var MON  = GLB_MONTH_IN_YEAR[month-1];
    var mon  = GLB_SHORT_MONTH_IN_YEAR[month-1];
    var DD   = (("" + day).length == 1) ? "0" + day : "" + day;
    var DAY  = GLB_DAY_IN_WEEK[dayInWeek];
    var day  = GLB_SHORT_DAY_IN_WEEK[dayInWeek];
    var HH   = (("" + hour24).length == 1) ? "0" + hour24 : "" + hour24;
    var hh   = (("" + hour12).length == 1) ? "0" + hour12 : "" + hour12;
    var mm   = (("" + min).length == 1) ? "0" + min : "" + min;
    var ss   = (("" + sec).length == 1) ? "0" + sec : "" + sec;
    var SS   = "" + this.getMilliseconds();

    var dateStr;
    var index = -1;

    if (typeof(pattern) == "undefined") {
    	dateStr = "YYYYMMDD";
    } else {
    	dateStr = pattern;
    }

	dateStr = dateStr.replace(/YYYY/g, YYYY);
	dateStr = dateStr.replace(/YY/g,   YY);
	dateStr = dateStr.replace(/MM/g,   MM);
	dateStr = dateStr.replace(/MON/g,  MON);
	dateStr = dateStr.replace(/mon/g,  mon);
	dateStr = dateStr.replace(/DD/g,   DD);
	dateStr = dateStr.replace(/DAY/g,  DAY);
	dateStr = dateStr.replace(/day/g,  day);
	dateStr = dateStr.replace(/hh/g,   hh);
	dateStr = dateStr.replace(/HH/g,   HH);
	dateStr = dateStr.replace(/mm/g,   mm);
	dateStr = dateStr.replace(/ss/g,   ss);
	dateStr = dateStr.replace(/(\s+)a/g, "$1" + ampm);

	return dateStr;
}

/**
 * @type   : prototype_function
 * @object : Date
 * @access : public
 * @desc   : 현재 Date 객체의 날짜보다 이후날짜를 가진 Date 객체를 리턴한다.
 *           예를 들어 내일 날짜를 얻으려면 다음과 같이 하면 된다.
 * <pre>
 *     var oneDayAfter = new Date.after(0, 0, 1);
 * </pre>
 * @sig    : [years[, months[, dates[, hours[, minutes[, seconds[, mss]]]]]]]
 * @param  : years   optional 이후 년수
 * @param  : months  optional 이후 월수
 * @param  : dates   optional 이후 일수
 * @param  : hours   optional 이후 시간수
 * @param  : minutes optional 이후 분수
 * @param  : seconds optional 이후 초수
 * @param  : mss     optional 이후 밀리초수
 * @return : 이후날짜를 표현하는 Date 객체
 * @author : GAUCE
 */
Date.prototype.after = function(years, months, dates, hours, miniutes, seconds, mss) {
    if (years == null)    years    = 0;
    if (months == null)   months   = 0;
    if (dates == null)    dates    = 0;
    if (hours == null)    hours    = 0;
    if (miniutes == null) miniutes = 0;
    if (seconds == null)  seconds  = 0;
    if (mss == null)      mss      = 0;

	return new Date(this.getFullYear() + years,
	                this.getMonth() + months,
	                this.getDate() + dates,
	                this.getHours() + hours,
	                this.getMinutes() + miniutes,
	                this.getSeconds() + seconds,
	                this.getMilliseconds() + mss
	               );
}
// alert(new Date().after(1, 1, 1, 1, 1, 1).format("YYYYMMDD HHmmss"));

/**
 * @type   : prototype_function
 * @object : Date
 * @access : public
 * @desc   : 현재 Date 객체의 날짜보다 이전날짜를 가진 Date 객체를 리턴한다.
 *           예를 들어 어제 날짜를 얻으려면 다음과 같이 하면 된다.
 * <pre>
 *     var oneDayBefore = new Date.before(0, 0, 1);
 * </pre>
 * @sig    : [years[, months[, dates[, hours[, minutes[, seconds[, mss]]]]]]]
 * @param  : years   optional 이전으로 돌아갈 년수
 * @param  : months  optional 이전으로 돌아갈 월수
 * @param  : dates   optional 이전으로 돌아갈 일수
 * @param  : hours   optional 이전으로 돌아갈 시간수
 * @param  : minutes optional 이전으로 돌아갈 분수
 * @param  : seconds optional 이전으로 돌아갈 초수
 * @param  : mss     optional 이전으로 돌아갈 밀리초수
 * @return : 이전날짜를 표현하는 Date 객체
 * @author : GAUCE
 */
Date.prototype.before = function(years, months, dates, hours, miniutes, seconds, mss) {
    if (years == null)    years    = 0;
    if (months == null)   months   = 0;
    if (dates == null)    dates    = 0;
    if (hours == null)    hours    = 0;
    if (miniutes == null) miniutes = 0;
    if (seconds == null)  seconds  = 0;
    if (mss == null)      mss      = 0;

	return new Date(this.getFullYear() - years,
	                this.getMonth() - months,
	                this.getDate() - dates,
	                this.getHours() - hours,
	                this.getMinutes() - miniutes,
	                this.getSeconds() - seconds,
	                this.getMilliseconds() - mss
	               );
}
//alert(new Date().before(1, 1, 1, 1, 1, 1).format("YYYYMMDD HHmmss"));

/**
 * @type   : function
 * @access : public
 * @desc   : 공통메세지에 정의된 메세지를 alert box로 보여준 후 리턴한다. cfGetMsg 참조.
 * @sig    : msgId[, paramArray]
 * @param  : msgId required common.js의 공통 메세지 영역에 선언된 메세지 ID
 * @param  : paramArray optional 메세지에서 '@' 문자와 치환될 데이터 Array. Array의 index와 메세지 내의 '@' 문자의 순서가 일치한다.
             치환될 데이터는 [] 사이에 콤마를 구분자로 하여 기술하면 Array 로 인식된다.
 * @return : 치환된 메세지 스트링
 * @author : GAUCE
 */
function cfAlertMsg(msgId, paramArray) {
	if (cfIsNull(msgId)) {
		alert("존재하지 않는 메시지입니다.");
		return null;
	}

	var msg = new coMessage().getMsg(msgId, paramArray);
	alert(msg);
	return msg;
}

/**
 * @type   : function
 * @access : public
 * @desc   : 필드에 최대 자릿수를 입력한 후 지정된 다른 필드로 포커스가 자동으로 이동된다.<br>
 *           html의 <Input type="text"> 와 가우스 EMEdit에서 사용가능하다. <Input type="text"> 의 경우
 *           maxLength 속성이 지정되어 있어야 하며 EMEdit의 경우 MaxLength와 Format 속성중 하나가 반드시
 *           기술되어야 한다.<br>
 *           byte length(한글)은 지원하지 않는다.<br>
 *           오브젝트 선언시 onkeydown 이벤트에 다음과 같이 기술해 주어야만 한다.
 * <pre>
 *     주민번호
 *     &lt;input id="oSsn1" type="text" size="6" maxLength="6" onkeydown="cfAutoFocusNext(this, oSsn2)"&gt;-
 *     &lt;input id="oSsn2" type="text" size="7" maxLength="7"&gt;
 * </pre>
 * @sig    : oElement, oNextElement
 * @param  : oElement required 현재 입력필드
 * @param  : oNextElement required 자동으로 포커스가 이동될 필드
 * @author : GAUCE
 */
/*
function cfAutoFocusNext(oElement, oNextElement) {
	if (event.keyCode == 8 ||   // backspace
	    event.keyCode == 37 ||  // left key
	    event.keyCode == 38 ||  // up key
	    event.keyCode == 39 ||  // right key
	    event.keyCode == 40 ||  // down key
	    event.keyCode == 46     // delete key
	   ) {
	   	return;
	}

	var value;
	var maxLength = 0;

	switch (cfGetElementType(oElement)) {
		case "TEXT" :
			value = oElement.value;
			maxLength = oElement.maxLength;

			if (value.length + 1 == maxLength) {
				oElement.value = oElement.value + String.fromCharCode(event.keyCode);
				event.returnValue = false;
				oNextElement.focus();
			}

			break;
		case "GE" :
			value = oElement.Text;

			if (cfIsNull(oElement.Format)) {
				maxLength = oElement.MaxLength;
			} else {
				for (var i = 0; i < oElement.Format.length; i++) {
					if (cfIsIn(oElement.Format.charAt(i), ['#', 'A', 'Z', '0', '9', 'Y', 'M', 'D'])) {
						maxLength++;
					}
				}
			}

			if (value.length + 1 == maxLength) {
				oElement.Text = oElement.Text + String.fromCharCode(event.keyCode);
				event.returnValue = false;
				oNextElement.focus();
			}

			break;
		default :
			return;
	}
}
*/


/**
 * @type   : function
 * @access : public
 * @desc   : 필드에 최대 자릿수를 입력한 후 지정된 다른 필드로 포커스가 자동으로 이동된다.<br>
 *           html의 <Input type="text"> 와 가우스 EMEdit에서 사용가능하다. <Input type="text"> 의 경우
 *           maxLength 속성이 지정되어 있어야 하며 EMEdit의 경우 MaxLength와 Format 속성중 하나가 반드시
 *           기술되어야 한다.<br>
 *           byte length(한글)은 지원하지 않는다.<br>
 *           오브젝트 선언시 onkeydown 이벤트에 다음과 같이 기술해 주어야만 한다.
 * <pre>
 *     주민번호
 *     &lt;input id="oSsn1" type="text" size="6" maxLength="6" onkeydown="cfAutoFocusNext(this, oSsn2)"&gt;-
 *     &lt;input id="oSsn2" type="text" size="7" maxLength="7"&gt;
 * </pre>
 * @sig    : oElement, oNextElement
 * @param  : oElement required 현재 입력필드
 * @param  : oNextElement required 자동으로 포커스가 이동될 필드
 * @author : GAUCE
 */
/*
function cfAutoFocusBefore(oElement, oBeforeElement) {
	if (event.keyCode != 8) {
	   	return;
	}

	var value;

	switch (cfGetElementType(oElement)) {
		case "TEXT" :
			value = oElement.value;
			break;
		case "GE" :
			value = oElement.Text;
			break;
		default :
			return;
	}

	if (value.length == 1) {
		oElement.value = "";
		event.returnValue = false;
		oBeforeElement.focus();
	}
}
*/

/**
 * @type   : function
 * @access : public
 * @desc   : 화면명을 만들어주는 함수
 * @sig    : title, pageId[, features]
 * @param  : title  required 화면명
 * @param  : pageId required 도움말을 위한 화면 id. 화면의 파일명에서 ".html"을 제외한 스트링을 주면 된다. 이 파라미터는
 *                    차후 도움말을 띄우기 위한 파라미터로써 현재 도움말에 대해서는 정의된 것이 없음.
 * @param  : features optional 기타 속성을 정의하는 스트링. 속성종류는 아래와 같다.
 * <pre>
 *     windowType : 현재창의 형태 (0:기본창, 1:팝업창, 2:다이얼로그창). (default:0)
 *     width      : 화면 영역의 width. (default:638)
 *     height     : 화면 영역의 height. (default:500)
 *     showHelp   : 도움말버튼을 보여줄지 여부. (default:yes)<br>
 *     사용예) "width=300,height=300,showHelp=no"
 * </pre>
 * @author : GAUCE
 */

function cfBuildBodyTitle(title, pageId, features, ssoHelpPage) {
	var featureNames  = ["windowType", "width", "height", "showHelp"];
	var featureValues = [0, 636, 498, true];
	var featureTypes  = ["number", "number", "number", "boolean"];

	if (features != null) {
		cfParseFeature(features, featureNames, featureValues, featureTypes);
	}

	var windowType  = featureValues[0];
	var width       = featureValues[1];
	var height      = featureValues[2];
	var showHelp    = featureValues[3];

	var marginTop    = 10;
	var marginLeft   = 10;
	var marginRight  = 18;
	var marginBottom = 8;

	var rightSizeBarLeft = width - marginRight;
	var bottomSizeBarTop = height - marginBottom;
	var helpWindowWidth = 620;
	var helpWindowHeight = 500;

        // 물량정보와 공통정보의 iom 이 동일하여 발생하는 현상 오류 수정
        var sysFncCd  = pageId.substr(0, 6);
        var sysCd = "" ;
        if ( sysFncCd == "iomfot" )  {
           sysCd = "iim";
        } else {
	   sysCd = cfGetSysCdFromPageId(pageId);
	}

	var subCd = pageId.substr(1, 2);
    var fncCd  = pageId.substr(3, 3);


    if (ssoHelpPage == null)
	{
		var helpLink = "onclick=\"window.open('"+GLB_URL_COMMON_PAGE+"../" + sysCd + "/help/" + subCd + "/" + fncCd + "/help_" + pageId + ".html', 'helpWindow', " +
		               "'left=" + ((screen.availWidth - helpWindowWidth) / 2 - 7) + ",top=" + (screen.availHeight - helpWindowHeight) / 2 +
			           ",height=" + helpWindowHeight + ",width=" + helpWindowWidth + ",status=no,toolbar=no,menubar=no,location=no,scrollbars=yes')\"";
	} else {
		var helpLink = "onclick=\"window.open('"+ getServerDNS() +"/sso/dmshelps/help_" + pageId + ".html', 'helpWindow', " +
		               "'left=" + ((screen.availWidth - helpWindowWidth) / 2 - 7) + ",top=" + (screen.availHeight - helpWindowHeight) / 2 +
			           ",height=" + helpWindowHeight + ",width=" + helpWindowWidth + ",status=no,toolbar=no,menubar=no,location=no,scrollbars=yes')\"";
	}
	var helpAreaLeft = width - 72;
    /*
	var helpArea = "<img src='" + GLB_URL_COMMON_PAGE + "images/bullet_help.gif' style='cursor:hand;' hideFocus='true' border='0' " + helpLink + ">" +

	               "<span class='txtHelp' style='cursor:hand;' " + helpLink + ">도움말</span>";
    */
    var helpArea = "";
    //document.write("<div style='position:absolute; left:" + marginLeft + "; top:" + marginTop + "; '><img src='" + GLB_URL_COMMON_PAGE + "images/bullet_bodytitle.gif'><font class='txtTitleBody'>" + title + "</font></div>");
    //document.write("<div style='position:absolute; left:" + marginLeft + "; top:" + marginTop + "; '><img src='" + "images/bullet_bodytitle.gif'><font class='txtTitleBody'>" + title + "</font></div>");
    document.write("<div style='position:absolute; left:" + marginLeft + "; top:" + marginTop + "; '><font class='txtTitleBody'>" + title + "</font></div>");

	// 도움말 버튼 작성
	if (showHelp) {
		if (windowType == 1) {
			document.write("<div style='width:52; position:absolute; left:" + (helpAreaLeft + 10) + "; top:" + marginTop + ";'>" + helpArea + "</div>");
		} else if (windowType == 2) {
			document.write("<div style='width:52; position:absolute; left:" + (helpAreaLeft + 4) + "; top:" + marginTop + ";'>" + helpArea + "</div>");
		} else {
			document.write("<div style='width:52; position:absolute; left:" + helpAreaLeft + "; top:" + marginTop + ";'>" + helpArea + "</div>");
		}
	}

	// 이 부분은 화면 여백과 사이즈를 표시하기 위한 부분으로 설계가 끝난 후 삭제 예정.
/*
	document.write("<table cellspacing='0' cellpadding='0' style='position:absolute; left:0; top:0;'><tr><td width='" + width + "' height='" + marginTop + "' bgcolor='#D6D6D6'></td></tr></table>");

	if (windowType == 1) {
		document.write("<table cellspacing='0' cellpadding='0' style='position:absolute; left:0; top:0;'><tr><td nowrap width='" + width + "' height='" + marginTop + "' bgcolor='#D6D6D6'></td></tr></table>");  // 북
		document.write("<div style='position:absolute; left:" + (rightSizeBarLeft + 10) + "; top:0;   width:" + (marginRight - 8) + ";  height:" + height + "; background-color:#D6D6D6;'></div>");               // 동
		document.write("<table cellspacing='0' cellpadding='0' style='position:absolute; left:0; top:" + bottomSizeBarTop + ";'><tr><td nowrap width='" + width + "' height='" + marginBottom + "' bgcolor='#D6D6D6'></td></tr></table>");  // 남
		document.write("<div style='position:absolute; left:0;   top:0;   width:" + marginLeft + ";  height:" + height + "; background-color:#D6D6D6;'></div>"); // 서
	} else if (windowType == 2) {
		document.write("<table cellspacing='0' cellpadding='0' style='position:absolute; left:0; top:0;'><tr><td nowrap width='" + (width - 6) + "' height='" + marginTop + "' bgcolor='#D6D6D6'></td></tr></table>");
		document.write("<div style='position:absolute; left:" + (rightSizeBarLeft + 4) + "; top:0;   width:" + (marginRight - 8) + ";  height:" + (height - 25) + "; background-color:#D6D6D6;'></div>");
		document.write("<table cellspacing='0' cellpadding='0' style='position:absolute; left:0; top:" + (bottomSizeBarTop - 25) + ";'><tr><td nowrap width='" + (width - 6) + "' height='" + marginBottom + "' bgcolor='#D6D6D6'></td></tr></table>");
		document.write("<div style='position:absolute; left:0;   top:0;   width:" + marginLeft + ";  height:" + (height - 25) + "; background-color:#D6D6D6;'></div>");
	} else {
		document.write("<table cellspacing='0' cellpadding='0' style='position:absolute; left:0; top:0;'><tr><td nowrap width='" + width + "' height='" + marginTop + "' bgcolor='#D6D6D6'></td></tr></table>");
		document.write("<div style='position:absolute; left:" + rightSizeBarLeft + "; top:0;   width:" + marginRight + ";  height:" + (height-5) + "; background-color:#D6D6D6;'></div>");
		document.write("<table cellspacing='0' cellpadding='0' style='position:absolute; left:0; top:" + bottomSizeBarTop + ";'><tr><td nowrap width='" + width + "' height='" + marginBottom + "' bgcolor='#D6D6D6'></td></tr></table>");
		document.write("<div style='position:absolute; left:0;   top:0;   width:" + marginLeft + ";  height:" + height + "; background-color:#D6D6D6;'></div>");
	}
*/
}

/**
 * @type   : function
 * @access : private
 * @desc   : cfFillGridHeader에서 사용하는 함수. 해당 페이지의 데이터를 요청한다.
 * @sig    : oDataSet, action, parameter, pageNo
 * @param  : oDataSet  required body내에 div 태그로 선언된 Header 영역 element
 * @param  : action    required Grid의 DataId에 선언된 DataSet 오브젝트를 Reset()하기 위한 서블릿과 Command클래스.
 * @param  : parameter required 페이지를 읽어오기위한 검색조건. Grid의 DataSet의 첫번째 row의 param 컬럼에 있음.
 * @param  : pageNo    required 보여줄 페이지 번호
 * @param  : rsltCnt   required 보여줄 총 데이터수
 * @author : GAUCE
 */
function cfChangePage(oGridHeader, action, parameter, pageNo, rsltCnt, confirmChangePage) {
	if (useChangeCursor == true)
	{
	    cfChangeCursor(1);
	}
	var oDataSet = document.all(document.all(oGridHeader.gridId).DataId);
	var oTR      = (oGridHeader.trId == null) ? null : document.all(oGridHeader.trId);

	if (oDataSet.isUpdated && !cfConfirmMsg(MSG_COM_CRM_005)) {
		return;
	}
	var paramArray = parameter.split("&");
	var newParameter = "";

	for (var i = 1; i < paramArray.length; i++) {
		if (paramArray[i].substr(0, 6) == "pageNo") {
			paramArray[i] = "pageNo=" + pageNo;
		}
		newParameter = newParameter + "&" + paramArray[i];
	}

	newParameter = newParameter + "&rsltCnt=" + rsltCnt;
	if (cfIsNull(oTR)) {
		oDataSet.DataId = action + newParameter;
		oDataSet.Reset();
	} else {
		oTR.Action = action + newParameter;
		oTR.Post();
	}
}


/**

 * @type   : function

 * @access : private

 * @desc   : cfFillGridHeader에서 사용하는 함수. 해당 페이지의 데이터를 요청한다. startpageno/endpageno로 데이터 reset처리

 * @sig    : oDataSet, action, parameter, pageNo

 * @param  : oDataSet  required body내에 div 태그로 선언된 Header 영역 element

 * @param  : action    required Grid의 DataId에 선언된 DataSet 오브젝트를 Reset()하기 위한 서블릿과 Command클래스.

 * @param  : parameter required 페이지를 읽어오기위한 검색조건. Grid의 DataSet의 첫번째 row의 param 컬럼에 있음.

 * @param  : startPageNo - 시작 페이지 번호

 * @author : 조부구

 */



 function cfChangePagePeriod(oDataSet, action, parameter, startPageNo, confirmChangePage) {

	if (oDataSet.isUpdated && !cfConfirmMsg(MSG_CONFIRM_CONTINUE_WITHOUT_APPLY)) {

		return;

	}



	var paramArray = parameter.split("&");

	var newParameter = "";



	for (var i = 1; i < paramArray.length; i++) {

		if (paramArray[i].substr(0, 11) == "startPageNo") {

			paramArray[i] = "startPageNo=" + startPageNo;

		}

		if (paramArray[i].substr(0, 9) == "endPageNo") {

			paramArray[i] = "endPageNo=" + startPageNo;

		}



		newParameter = newParameter + "&" + paramArray[i];

	}



	oDataSet.DataId = action + newParameter;

	oDataSet.Reset();

}



/**

 * @type   : function

 * @access : public

 * @desc   : 공통메세지에 정의된 메세지를 confirm box로 보여준 후 리턴한다. cfGetMsg 참조.

 * @sig    : msgId[, paramArray]

 * @param  : msgId      required common.js의 공통 메세지 영역에 선언된 메세지 ID

 * @param  : paramArray optional 메세지에서 '@' 문자와 치환될 스트링 Array. (Array의 index와

 *           메세지 내의 '@' 문자의 순서가 일치한다.)

 * @return : 치환된 메세지 스트링

 * @author : GAUCE

 */

function cfConfirmMsg(msgId, paramArray) {

	if (cfIsNull(msgId)) {

		alert("존재하지 않는 메시지입니다.");

		return null;

	}



	return confirm(new coMessage().getMsg(msgId, paramArray));

}



/**

 * @type   : function

 * @access : public

 * @desc   : 가우스의 데이터셋 오브젝트 간에 데이터를 복사한다. 복사대상이 되는 데이터셋의 기존의 데이터는 모두 삭제된다.

 *           features 파라미터에서 copyHeader를 yes로 할 경우 DataSet의 컬럼정보까지 복사된다.

 * <pre>

 *    cfCopyDataSet(oDelivRsltOriginGDS, oDelivRsltCopiedGDS, "copyHeader=no");

 * </pre>

 * @sig    : oOriginDataSet, oTargetDataSet[, features]

 * @param  : oOriginDataSet required 원본 DataSet

 * @param  : oTargetDataSet required 복사되어질 DataSet

 * @param  : features       optional 기타 속성을 정의하는 스트링. 속성종류는 아래와 같다.

 * <pre>

 *     copyHeader  : Header를 복사할지 여부. (default:yes)

 *     resetStatus : 복사된 DataSet의 Status를 reset 할 지 여부. (default:yes)

 *     rowFrom     : 복사할 row의 시작 index. (default:1)

 *     rowCnt      : 복사할 row의 갯수 index. (default:DataSet.CountRow 의 값)

 *     사용예) "copyHeader=yes,rowFrom=1,rowCnt=2"  -> 1번 row 부터 3번 row까지 Header와 함께 복사함.

 * </pre>

 * @author : GAUCE

 */

function cfCopyDataSet(oOriginDataSet, oTargetDataSet, features) {

	var featureNames  = ["copyHeader", "resetStatus", "rowFrom", "rowCnt"];

	var featureValues = [true, true, 1, oOriginDataSet.CountRow];

	var featureTypes  = ["boolean", "boolean", "number", "number"];



	if (features != null) {

		cfParseFeature(features, featureNames, featureValues, featureTypes);

	}



	var copyHeader  = featureValues[0];

	var resetStatus = featureValues[1];

	var rowFrom     = featureValues[2];

	var rowCnt      = featureValues[3];



	if (copyHeader == true) {

		cfCopyDataSetHeader(oOriginDataSet, oTargetDataSet);

	}



	oTargetDataSet.ClearData();

	if (oOriginDataSet.CountRow > 0) {

		var temp = oTargetDataSet.dataid;  // importdata를 한 후 DataSet의 기존의 dataid 속성값이 지워지는 것을 방지.

		oTargetDataSet.ImportData(oOriginDataSet.ExportData(rowFrom, rowCnt, true));

		oTargetDataSet.dataid = temp;



		if (resetStatus == true) {

			oTargetDataSet.ResetStatus();

		}

	}

}



/**

 * @type   : function

 * @access : public

 * @desc   : 가우스의 데이터셋 오브젝트 간에 컬럼 헤더 정보를 복사한다.

 * <pre>

 *    cfCopyDataSet(oDelivRsltOriginGDS, oDelivRsltCopiedGDS);

 * </pre>

 * @sig    : oOriginDataSet, oTargetDataSet

 * @param  : oOriginDataSet required 원본 DataSet

 * @param  : oTargetDataSet required 복사되어질 DataSet

 * @author : GAUCE

 */

function cfCopyDataSetHeader(oOriginDataSet, oTargetDataSet) {

	var DsHeader = "";

	var colId   = "";

	var colType = "";

	var colProp = "";

	var colSize = ""



	for (var i = 1; i <= oOriginDataSet.CountColumn; i++) {

 		colId   = oOriginDataSet.ColumnID(i);	     //column id

		colIndex= oOriginDataSet.ColumnIndex(colId);  //column id에 해당하는 index값

		colSize = oOriginDataSet.ColumnSize(colIndex);//column size



		/* column의 type 정의 코드



			Type  Description

			-----------------

			 1    String

			 2    Integer

			 3    Decimal

			 4    Date

			 5    URL

		*/



		//column type정의

		switch (oOriginDataSet.ColumnType(colIndex)){

		     case 1 :

		              colType = 'String';

		              break;

		     case 2 :

		              colType = 'Integer';

		              break;

		     case 3 :

		              colType = 'Decimal';

		              break;

		     case 4 :

		              colType = 'Date';

		              break;

		     case 5 :

		              colType = 'URL';

		              break;



		     default :

		              colType = "";

		              break;

		}



		/* column의 property 정의

			0 : Normal (Key = No)

			1 : Constant

			2 : Key (Normal, Sequence)

			3 : Sequence (Key = No) // 현재 의미없음.

		*/

		switch (oOriginDataSet.ColumnProp(i)) {

		     case 0 :

		              colProp = "NORMAL";

		              break;

		     case 1 :

		              colProp = "CONSTANT";

		              break;

		     case 2 :

		              colProp = "KEYVALUE";

		              break;

		     default :

		              colProp = "";

		              break;

		}



		//column id,column type,column size, column property

		DsHeader = DsHeader + colId + ":" + colType + "(" + colSize + ")" + ":" + colProp + ",";

	}



	DsHeader = DsHeader.substr(0, DsHeader.length - 1);

	oTargetDataSet.SetDataHeader(DsHeader);

}



/**

 * @type   : function

 * @access : public

 * @desc   : 가우스 Grid Object에서 선택(데이터셋의 데이터) 되어 있는 record를 복사하여

 			 붙여넣기(데이터셋에 Row를 추가)를 한다.

 * <pre>

 *    cfCopyRecord(oDataSet);

 * </pre>

 * @sig    : oDataSet

 * @param  : oDataSet required 복사/붙여넣기할 동일 데이터셋 이름

 * @author : GAUCE

 */

function cfCopyRecord(oDataSet) {

		var tempdata = '';

		for (j=1;j<=oPgmRegGDS.countrow;j++){

			if (oPgmRegGDS.rowmark(j) == 1){

				tempdata += oPgmRegGDS.ExportData(j,1,true);

			}

		}

		oPgmRegGDS.Importdata(tempdata);

}



/**

 * @type   : function

 * @access : public

 * @desc   : Grid의 선택된 Row들을 삭제한다.

 * <pre>

 *     cfDeleteGridRow(oDomRegiRecevGG);

 * </pre>

 * 위의 예에서 oDomRegiRecevGDS 라는 id를 가진 Grid의 현재 선택된 Row들은 모두 삭제된다.<br><br>

 * <font color=red>

 * 기존의 cfDeleteGridRow 함수의 파라미터는 DataSet이었으나 Grid의 MultiRowSelect 속성이 false일 경우

 * 이 함수를 사용하면 마지막 row를 삭제할 때 Grid의 모든 row가 삭제되는 버그가 있었다. 따라서 파라미터가

 * Grid로 바뀌었다. 하지만 기존에 MultiRowSelect 속성이 true인 경우에는 문제가 없었으므로 궂이 소스변경을

 * 강요할 수 없다. 따라서 기존에 MultiRowSelect 속성이 true 이면서 파라미터를 DataSet으로 사용한 경우에는

 * 변경없이 동작되도록 작성되었다.

 * </font>

 *

 * @sig    : oGrid

 * @param  : oGrid required Grid 오브젝트

 * @author : GAUCE

 */

function cfDeleteGridRows(obj) {

	if (obj.attributes.classid == null) {

		return;

	}



	var oDataSet;

	var oGrid;



	switch (obj.attributes.classid.nodeValue.toUpperCase()) {

		case "CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49": // DataSet Component

			oDataSet = obj;

			break;

		case "CLSID:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49": // Grid Component

			oGrid    = obj;

			oDataSet = document.all(oGrid.DataID);

			break;

	}



	if (oGrid != null && oGrid.MultiRowSelect == false) {

		oDataSet.DeleteRow(oDataSet.RowPosition);

		return;

	} else {

		for (var i = oDataSet.CountRow; i > 0; i--) {

			if (oDataSet.RowMark(i)) {

				oDataSet.DeleteRow(i);

			}

		}

	}

}



/**

 * @type   : function

 * @access : public

 * @desc   : 자바스크립트의 숫자 앞에 지정된 자릿수만큼 zero character 를 삽입한다.

 * <pre>

 *     cfDigitalNumber(5, 123);

 * </pre>

 * 위와같이 사용했을 경우 "00123" 이라는 String을 리턴한다.

 * @sig    : length, number

 * @param  : length required 숫자를 표현하는 길이
 * @param  : number required 변환될 숫자
 * @return : 변환된 스트링

 * @author : GAUCE

 */

function cfDigitalNumber(length, number) {

	var numStr = number + "";

	var zeroChars = "";



	for (var i = 0; i < (length - number.length); i++) {

		zeroChars = zeroChars + "0";

	}



	return (zeroChars + numStr);

}



/**

 * @type   : function

 * @access : public

 * @desc   : element를 disable 시킨다.

 * <pre>

 *     cfDisable(oRegistBtn);

 * </pre>

 * @sig    : oElement

 * @param  : oElement required disable 하고자 하는 element
 * @author : GAUCE

 */

function cfDisable(obj) {

	if (cfIsNull(obj)) {

		return;

	}



	if (obj.length != null) {

		for (var i = 0; i < obj.length; i++) {

			cfProcessChildElement(obj[i], cfDisableElement);

		}

	} else {

		cfProcessChildElement(obj, cfDisableElement);

	}

}



/*

	- <input type=text> 의 경우 disable시에 글자색을 지정할 수 없다. 따라서 disable 대신 readOnly로 바꾼다.

	- EMEdit의 경우 역시 disable시에 글자색을 지정할 수 없다. 따라서 disable 대신 readOnly로 바꾼다.

	- 가우스 Radio는 ReadOnly가 없으며 Enable을 false로 설정하면 글자색을 바꿀 수가 없다. 글자색바꿈 포기.

	- <input type=checkbox> 의 경우 ReadOnly가 없으며 disabled를 true로 할 경우 box내부 색깔을 바꿀 수가 없다. box 색바꿈 포기.

	- 가우스 CodeCombo의 경우 InheritColor속성을 true로 하라고 가이드하였으며 InheritColor속성이 true일 경우, 배경색과

	  글자색을 모두 바꿀 수가 있다. 단, ReadOnly는 없으며 Enable을 false로 해야 한다. Enable이 false일 경우는 배경색과 글자색이

	  고정되어서 바꿀 수가 없다.

*/

function cfDisableElement(oElement, argArr) {

	switch (cfGetElementType(oElement)) {

		case "BUTTON" :

			oElement.disabled = true;



			if (oElement.className != null &&

			    (oElement.className.substr(0, 7) == "btnGrid" ||

			     oElement.className.substr(0, 7) == "btnIcon" ) &&

			   	oElement.currentStyle.backgroundImage.substr(oElement.currentStyle.backgroundImage.length - 15, 9) != "_disabled"

			   ) {

			   	oElement.style.backgroundImage =

			   		oElement.currentStyle.backgroundImage.substr(0, oElement.currentStyle.backgroundImage.length - 6) + "_disabled" +

			   		oElement.currentStyle.backgroundImage.substr(oElement.currentStyle.backgroundImage.length - 6);

			}



			break;



		case "CHECKBOX" :

		case "RADIO" :

		case "RESET" :

		case "SELECT" :

		case "SUBMIT" :

			oElement.disabled = true;

			break;



		case "FILE" :

		case "PASSWORD" :

		case "TEXT" :

		case "TEXTAREA" :

			oElement.disabled = true;

			//oElement.tabIndex = "-1";

			//oElement.style.color = "#454648";  // 일반 텍스트 기본색상

			oElement.style.color = "#808080";    // EMEdit Disable시 색상과 동일.

			oElement.style.backgroundColor = "#E9E9E9";  // HTML 오브젝트의 기본 disabled color.

			                                             // Text는 background가 하얀색으로 남는다. 따라서 스타일로 임의로 지정하였음.

			break;



		case "GE" :

//			oElement.ReadOnly = true;

//			oElement.ReadOnlyBackColor = "#DEDEDE";

//			oElement.ReadOnlyForeColor = "#454648";

			oElement.ReadOnlyForeColor = "#808080";

			oElement.Enable = false;

			oElement.DisabledBackColor = "#E9E9E9";

			break;



		case "GCC" :

			oElement.Enable = false;

			break;



		case "GIF" :

		case "GRDO" :

		case "GTA" :

			oElement.Enable = false;

			break;



		default :

			break;

	}

}



/**

 * @type   : function

 * @access : public

 * @desc   : element를 enable 시킨다.

 * <pre>

 *     cfEnable(oRegistBtn);

 * </pre>

 * @sig    : oElement

 * @param  : oElement required enable 하고자 하는 element 혹은 element array
 * @author : GAUCE

 */

function cfEnable(obj) {

	if (cfIsNull(obj)) {

		return;

	}



	if (obj.length != null) {

		for (var i = 0; i < obj.length; i++) {

			cfProcessChildElement(obj[i], cfEnableElement);

		}

	} else {

		cfProcessChildElement(obj, cfEnableElement);

	}

}



function cfEnableElement(oElement, argArr) {

	switch (cfGetElementType(oElement)) {

		case "BUTTON" :

			oElement.disabled = false;



			if (oElement.className != null &&

			    (oElement.className.substr(0, 7) == "btnGrid" ||

			     oElement.className.substr(0, 7) == "btnIcon"

			    )

			   ) {

			   	if (oElement.currentStyle.backgroundImage.substr(oElement.currentStyle.backgroundImage.length - 15, 9) == "_disabled") {

				   	oElement.style.backgroundImage =

				   		oElement.currentStyle.backgroundImage.cut(oElement.currentStyle.backgroundImage.length - 15, 9);

				}

			}



			break;



		case "CHECKBOX" :

		case "RADIO" :

		case "RESET" :

		case "SELECT" :

		case "SUBMIT" :

			oElement.disabled = false;

			break;



		case "FILE" :

		case "PASSWORD" :

		case "TEXT" :

		case "TEXTAREA" :

			oElement.disabled = false;

			oElement.style.color = "#454648";

			oElement.style.backgroundColor = "";

			break;



		case "GE" :

//			oElement.ReadOnly = false;

			oElement.Enable = true;

			break;



		case "GCC" :

			oElement.Enable = true;

			break;



		case "GIF" :

		case "GRDO" :

		case "GTA" :

			oElement.Enable = true;

			break;



		default :

			break;

	}

}



/**

 * @type   : function

 * @access : public

 * @desc   : Grid에 대한 페이지 정보를 보여주는 Grid Header를 삽입한다. 이 함수는 페이징 기법을 사용할 경우 필요한 함수로써

 *           이 함수를 호출하면 페이징을 사용하는 Grid의 Header 부분에 페이징 정보가 자동으로 보여진다. 예를들어서 Grid 오브젝트의

 *           Header 오브젝트의 id 가 oDelivRsltGGHeader 라고 한다면, 다음과 같이 해당 Grid Header를 채울 수 있다.

 *           (페이징과 관련된 내용은 화면 개발 가이드 문서를 참조하기 바란다.)

 * <pre>

 * &lt;script language="javascript" for="oDelivRsltGDS" event="OnLoadCompleted()"&gt;

 *     cfFillGridHeader(oDelivRsltGGHeader, "pageLinkCnt=3");

 * &lt;/script&gt;

 * </pre>

 * @sig    : oGridHeader[, features]

 * @param  : oGridHeader required body내에 div 태그로 선언된 Grid Header 오브젝트

 * @param  : features    optional 기타 속성을 정의하는 스트링. 속성종류는 아래와 같다.

 * <pre>

 *     width        : Grid의 Width (default:608)

 *

 *     showTotal    : 총 조회건수 정보를 보여줄지의 여부. 조회건수 정보는 다음과 같은 형태로

 *                    브라우저에 보여진다. (default:yes)

 *

 *                    총건수:52

 *

 *     showPageInfo : "현재페이지번호/전체페이지수" 형태의 페이지 정보를 보여줄지의 여부.

 *                    페이지 정보는 다음과 같은 형태로 브라우저에 보여진다. (default:yes)

 *

 *                    페이지:1/7

 *

 *     pageLinkCnt  : Grid의 페이지 링크의 개수. 링크영역을 보여주지 않으려면 링크수를 0으로 하면 된다.

 *                    (검색된 페이지가 0일 경우에도 화면상에 나타나지 않는다.)

 *                    아래에 페이지 링크수가 3 일 경우의 예가 나와 있다.

 *                    (default:5)

 *

 *                    ◀[ 4 5 6 ]▶

 *

 *     confirmChangePage : 현재 페이지에 변경된 사항이 있으나 저장되지 않았을 경우에 Confirm Box를 띄울것인지의 여부.

 *                    (default:yes)

 * </pre>

 * @author : GAUCE

 */

function cfFillGridHeader(oGridHeader, features) {

	var pageNo          = 0;

	var rsltCnt         = 0;

	var pageCnt         = 0;

	var pageStartLinkNo = 0;

	var pageEndLinkNo   = 0;

	var prevBtn         = "&nbsp;";

	var nextBtn         = "&nbsp;";

	var prevPageSetBtn  = "";

	var nextPageSetBtn  = "";

	var totalArea       = "&nbsp;";

	var pageInfoArea    = "&nbsp;";

	var pageLinkArea    = "&nbsp;";

	var action          = "";

	var parameter       = "";

	var oDataSet        = document.all(document.all(oGridHeader.gridId).DataId);

	var oTR             = (oGridHeader.trId == null) ? null : document.all(oGridHeader.trId);



	var featureNames  = ["width", "showTotal", "showPageInfo", "pageLinkCnt", "showPageBtn", "confirmChangePage"];

	var featureValues = [608, true, true, 5, true, true];

	var featureTypes  = ["number", "boolean", "boolean", "number", "boolean", "boolean"];



	if (features != null) {

		cfParseFeature(features, featureNames, featureValues, featureTypes);

	}



	var width             = featureValues[0];

	var showTotal         = featureValues[1];

	var showPageInfo      = featureValues[2];

	var pageLinkCnt       = featureValues[3];

	var showPageBtn       = featureValues[4];

	var confirmChangePage = featureValues[5];



	// 디자이너의 요구에 의해 페이지 이동 버튼은 표현되지 않음.

	showPageBtn = false;



	if (cfIsNull(oTR)) {

		// Transaction 을 통해 검색된 경우에는 검색 후 DataSet의 DataId가 지워지므로 Post 호출전에

		// cfSavePageParameter 함수를 통해 전역변수에 저장해 놓은 값을 이용해야 한다.

		if (cfIsNull(oDataSet.DataId) && !cfIsNull(GLB_PAGE_PARAMS.getValue(oDataSet.id))) {

			oDataSet.DataId = GLB_PAGE_PARAMS.getValue(oDataSet.id);

		}

	}



	var actionData = null;



	if (cfIsNull(oTR)) {

		actionData = (oDataSet.DataId == null) ? "" : oDataSet.DataId;

	} else {

		actionData = (oTR.Action == null) ? "" : oTR.Action;

	}



	// Parsing DataSet.DataId

	if (actionData.indexOf("&") == -1) {

		action = actionData;

		parameter = "";

	} else {

		action = actionData.substring(0, actionData.indexOf("&"));

		parameter = actionData.substr(actionData.indexOf("&"));

	}



	// pageInfo = cfGetPageInfo(oDataSet);

	pageNo   = Number(cfGetPageInfo(oDataSet, "pageNo", 0));

	rsltCnt  = Number(cfGetPageInfo(oDataSet, "rsltCnt", 0));

	pageCnt  = Number(cfGetPageInfo(oDataSet, "pageCnt", 0));



	if (showPageBtn) {

		if (pageNo > 1) {

			prevBtn = "<a style='cursor:hand;' onclick=\"javascript:cfChangePage(" + oGridHeader.id + ", '" + action + "', '" + parameter + "', " + (pageNo - 1) + ", " + rsltCnt + ", " + confirmChangePage + ")\">◀ </a>";

		}



		if (pageNo < pageCnt) {

			nextBtn = "<a style='cursor:hand;' onclick=\"javascript:cfChangePage(" + oGridHeader.id + ", '" + action + "', '" + parameter + "', " + (pageNo + 1) + ", " + rsltCnt + ", " + confirmChangePage + ")\">▶</a>";

		}

	}



	if ( !isNaN(pageLinkCnt) && (pageLinkCnt != 0) && (pageNo != 0) ) {

		pageStartLinkNo = Math.floor( Math.abs(pageNo - 1) / pageLinkCnt ) * pageLinkCnt + 1;



		if (pageStartLinkNo == 1) {

			prevPageSetBtn = "";

		} else {

			prevPageSetBtn = "<a style='font-size:9pt; font-family:굴림; text-decoration:none; color:#212863; cursor:hand;' " +

			                 "onclick=\"cfChangePage(" +

			                 oGridHeader.id + ", '" + action + "', '" + parameter + "', " + (pageStartLinkNo - pageLinkCnt) + ", " + rsltCnt + ", " +

							 confirmChangePage + ")\">" + "◀ " + "</a>";

		}



		if ((pageStartLinkNo + pageLinkCnt - 1) < pageCnt) {

			pageEndLinkNo = pageStartLinkNo + pageLinkCnt - 1;

			nextPageSetBtn = "<a style='font-size:9pt; font-family:굴림; text-decoration:none; color:#212863; cursor:hand;' " +

			                 "onclick=\"cfChangePage(" +

			                 oGridHeader.id + ", '" + action + "', '" + parameter + "', " + (pageStartLinkNo + pageLinkCnt) + ", " + rsltCnt + ", " +

							 confirmChangePage +  ")\">" + " ▶" + "</a>";

		} else {

			pageEndLinkNo = pageCnt;

			nextPageSetBtn = "";

		}



		pageLinkArea = prevPageSetBtn + "<span style='font-size:9pt; font-family:굴림; color:#212863;'>[</span>";

		for (var i = pageStartLinkNo; i <= pageEndLinkNo; i++) {

			if (i != pageNo) {

				pageLinkArea = pageLinkArea + "<a style='font-size:9pt; font-family:굴림; text-decoration:none; color:#212863; cursor:hand;' " +

				               "onclick=\"cfChangePage(" +

				               oGridHeader.id + ", '" + action + "', '" + parameter + "', " + i + ", " + rsltCnt + ", " +

							   confirmChangePage + ")\"> " + i + " </a>";

			} else {

				pageLinkArea = pageLinkArea + "<span style='font-size:9pt; font-family:굴림; color:#5C8BE0; font-weight:bold;'> " + i + " </span>";

			}

		}

		pageLinkArea = pageLinkArea + "<span style='font-size:9pt; font-family:굴림; color:#212863;'>]</span>" + nextPageSetBtn;

	}



	if (showTotal) {

		totalArea = "<span style='font-size:9pt; font-family:굴림; color:#212863;'>총건수: </span><span style='font-size:9pt; font-family:굴림; color:#5C8BE0; font-weight:bold'>"+ rsltCnt + "</span>";

	}



	if (showPageInfo) {

		pageInfoArea = "<span style='font-size:9pt; font-family:굴림; color:#212863;'>";

		if (showTotal == true) {

			pageInfoArea = pageInfoArea + "&nbsp;&nbsp;";

		}



		pageInfoArea = pageInfoArea +  "페이지: </span><span style='font-size:9pt; font-family:굴림; color:#5C8BE0; font-weight:bold;'>" + pageNo + "/" + pageCnt + "</span>";

	}



	oGridHeader.innerHTML = "<table cellpadding='0' cellspacing='0' width='" + width + "'>" +

	                        "    <tr>" +

	                        "        <td align='left' width='1%' nowrap>" + totalArea + pageInfoArea + "</td>" +

	                        "        <td align='center'>" + pageLinkArea + "</td>" +

	                        "        <td align='right' width='30'>" + prevBtn + nextBtn + "</td>" +

	                        "        </td>" +

                            "    </tr>" +

                            "</table>";

}



/**

 * @type   : function

 * @access : private

 * @desc   : Grid에 대한 페이지 정보를 보여주는 Grid Header를 삽입한다. 예를들어서, pageinfo인 페이징 정보가

 *           있고 Grid 오브젝트의 Header 오브젝트의 id 가

 *           oDelivRsltGGHeader 라고 한다면, 다음과 같이 해당 Grid Header를 채울 수 있다.

 * <pre>

 * &lt;script language="javascript" for="oDelivRsltGDS" event="OnLoadCompleted()"&gt;

 *     cfFillGridHeaderPage(oDelivRsltGGHeader, pageInfo);

  * &lt;/script&gt;

 * </pre>

 * @sig    : oHeader,pageInfo

 * @param  : oHeader  - body내에 div 태그로 선언된 Grid Header의 id

 * @param  : pageInfo - Gauce dataset에서 정의한 pageinfo column값, Grid header부분에 표현할 전체 Recoder 수와 page수

  * <pre>

 *     width        : Grid의 Width (default:300)

  * <pre>

 *  	총건수:52

 * </pre>

 *     showPageInfo : "전체페이지수" 형태의 페이지 정보를 보여줄지의 여부.

 *                    페이지 정보는 다음과 같은 형태로 브라우저에 보여진다. (default:5)

 * <pre>

 *  	페이지:7

 * </pre>

 * @author : 조부구

 */

function cfFillGridHeaderPage(oHeader,pageInfo) {





	var rsltCnt         = 0;

	var pageCnt         = 0;

	var totalArea       = "&nbsp;";

	var pageInfoArea    = "&nbsp;";

	var pageLinkArea    = "&nbsp;";



	var featureNames  = ["width", "showTotal", "showPageInfo", "pageLinkCnt", "showPageBtn"];

	var featureValues = [300, true, true, 5, true];

	var featureTypes  = ["number", "boolean", "boolean", "number", "boolean"];



	var width        = featureValues[0];

	var showTotal    = featureValues[1];

	var showPageInfo = featureValues[2];

	var pageLinkCnt  = featureValues[3];

	var showPageBtn  = featureValues[4];



	rsltCnt  = Number(cfFillPageInfo(pageInfo, "rsltCnt"));

	pageCnt  = Number(cfFillPageInfo(pageInfo, "pageCnt"));



	if (showTotal) {

		totalArea = "<span style='font-size:9pt; font-family:굴림; color:#212863;'>총건수: </span><span style='font-size:9pt; font-family:굴림; color:#5C8BE0; font-weight:bold'>"+ rsltCnt + "</span>";

	}



	if (showPageInfo) {

		pageInfoArea = "<span style='font-size:9pt; font-family:굴림; color:#212863;'>";

		if (showTotal == true) {

			pageInfoArea = pageInfoArea + "&nbsp;&nbsp;";

		}



		pageInfoArea = pageInfoArea +  "페이지: </span><span style='font-size:9pt; font-family:굴림; color:#5C8BE0; font-weight:bold;'>" +"</span>";

	}



	oHeader.innerHTML = "<table cellpadding='0' cellspacing='0' width='" + width + "'>" +

	                    "    <tr>" +

	                    "        <td align='left' width='1%' nowrap>" + totalArea +"</td>" +

	                    "        <td align='left'>"+pageInfoArea+"<font id='page_cnt' style='font-size:9pt; font-family:굴림; color:#5C8BE0; font-weight:bold;'><font></td>" +

                        "    </tr>" +

                        "</table>";

                        page_cnt.innerText = pageCnt;

}



/**

 * @type   : function

 * @access : public

 * @desc   : cfFillGridHeader함수 비슷하며 보고서를 위한 paging기능을 추가하였다.(page from - to형식으로 paramater를 받는다)

 			 Grid에 대한 페이지 정보를 보여주는 Grid Header를 삽입한다. 이 함수는 페이징 기법을 사용할 경우 필요한 함수로써

 *           이 함수를 호출하면 페이징을 사용하는 Grid의 Header 부분에 페이징 정보가 자동으로 보여진다. 예를들어서 Grid 오브젝트의

 *           Header 오브젝트의 id 가 oDelivRsltGGHeader 라고 한다면, 다음과 같이 해당 Grid Header를 채울 수 있다.

 *           (페이징과 관련된 내용은 화면 개발 가이드 문서를 참조하기 바란다.)

 * <pre>

 * &lt;script language="javascript" for="oDelivRsltGDS" event="OnLoadCompleted()"&gt;

 *     cfFillGridHeaderPeriod(oDelivRsltGGHeader, "pageLinkCnt=3");

 * &lt;/script&gt;

 * </pre>

 * @sig    : oGridHeader[, features]

 * @param  : oGridHeader required body내에 div 태그로 선언된 Grid Header 오브젝트

 * @param  : features    optional 기타 속성을 정의하는 스트링. 속성종류는 아래와 같다.

 * <pre>

 *     width        : Grid의 Width (default:608)

 *

 *     showTotal    : 총 조회건수 정보를 보여줄지의 여부. 조회건수 정보는 다음과 같은 형태로

 *                    브라우저에 보여진다. (default:yes)

 * <pre>

 *  	총건수:52

 * </pre>

 *     showPageInfo : "현재페이지번호/전체페이지수" 형태의 페이지 정보를 보여줄지의 여부.

 *                    페이지 정보는 다음과 같은 형태로 브라우저에 보여진다. (default:yes)

 * <pre>

 *  	페이지:1/7

 * </pre>

 *     pageLinkCnt  : Grid의 페이지 링크의 개수. 링크영역을 보여주지 않으려면 링크수를 0으로 하면 된다.

 *                    아래에 페이지 링크수가 3 일 경우의 예가 나와 있다.

 *                    (default:5)

 * <pre>

 *  	◀[ 4 5 6 ]▶

 * </pre>

 *     confirmChangePage : 현재 페이지에 변경된 사항이 있으나 저장되지 않았을 경우에 Confirm Box를 띄울것인지의 여부.

 *                    (default:yes)

 * @author : 조부구

 */

function cfFillGridHeaderPeriod(oGridHeader, features) {



	var startPageNo          = 0;

	var rsltCnt         = 0;

	var pageCnt         = 0;

	var pageStartLinkNo = 0;

	var pageEndLinkNo   = 0;

	var dataId          = "";

	var prevBtn         = "&nbsp;";

	var nextBtn         = "&nbsp;";

	var prevPageSetBtn  = "";

	var nextPageSetBtn  = "";

	var totalArea       = "&nbsp;";

	var pageInfoArea    = "&nbsp;";

	var pageLinkArea    = "&nbsp;";

	var action          = "";

	var parameter       = "";

	var oDataSet        = document.all(document.all(oGridHeader.gridId).DataId);


	var featureNames  = ["width", "showTotal", "showPageInfo", "pageLinkCnt", "showPageBtn", "confirmChangePage"];

	var featureValues = [608, true, true, 5, true, true];

	var featureTypes  = ["number", "boolean", "boolean", "number", "boolean", "boolean"];



	if (features != null) {

		cfParseFeature(features, featureNames, featureValues, featureTypes);

	}



	var width             = featureValues[0];

	var showTotal         = featureValues[1];

	var showPageInfo      = featureValues[2];

	var pageLinkCnt       = featureValues[3];

	var showPageBtn       = featureValues[4];

	var confirmChangePage = featureValues[5];



	// 디자이너의 요구에 의해 페이지 이동 버튼은 표현되지 않음.

	showPageBtn = false;


	if (oDataSet.DataId.indexOf("&") == -1) {

		action = oDataSet.DataId;

		parameter = "";

	} else {

		action = oDataSet.DataId.substring(0, oDataSet.DataId.indexOf("&"));

		parameter = oDataSet.DataId.substr(oDataSet.DataId.indexOf("&"));

	}

 	dataId  = oDataSet.id;



	//pageInfo = cfGetPageInfo(oDataSet);

	startPageNo   = Number(cfGetPageInfo(oDataSet, "startPageNo", 0));

	rsltCnt  	  = Number(cfGetPageInfo(oDataSet, "rsltCnt", 0));

	pageCnt  	  = Number(cfGetPageInfo(oDataSet, "pageCnt", 0));



	if (showPageBtn) {

		if (startPageNo > 1) {

			prevBtn = "<a style='cursor:hand;' onclick=\"cfChangePage(" + dataId + ", '" + action + "', '" + parameter + "', " + (startPageNo - 1) + ", " + confirmChangePage + ")\">◀ </a>";

		}



		if (startPageNo < pageCnt) {

			nextBtn = "<a style='cursor:hand;' onclick=\"javascript:cfChangePage(" + dataId + ", '" + action + "', '" + parameter + "', " + (startPageNo + 1) + ", " + confirmChangePage + ")\">▶</a>";

		}

	}



	if ( !isNaN(pageLinkCnt) && (pageLinkCnt != 0) && (startPageNo != 0) ) {

		pageStartLinkNo = Math.floor( Math.abs(startPageNo - 1) / pageLinkCnt ) * pageLinkCnt + 1;



		if (pageStartLinkNo == 1) {

			prevPageSetBtn = "";

		} else {

			prevPageSetBtn = "<a style='font-size:9pt; font-family:굴림; text-decoration:none; color:#212863; cursor:hand;' " +

			                 "onclick=\"cfChangePagePeriod(" +

			                 dataId + ", '" + action + "', '" + parameter + "', " + (pageStartLinkNo - pageLinkCnt) +

			                 ", " + confirmChangePage + ")\">" + "◀ " + "</a>";

		}



		if ((pageStartLinkNo + pageLinkCnt - 1) < pageCnt) {

			pageEndLinkNo = pageStartLinkNo + pageLinkCnt - 1;

			nextPageSetBtn = "<a style='font-size:9pt; font-family:굴림; text-decoration:none; color:#212863; cursor:hand;' " +

			                 "onclick=\"cfChangePagePeriod(" +

			                 dataId + ", '" + action + "', '" + parameter + "', " + (pageStartLinkNo + pageLinkCnt) +

			                 ", " + confirmChangePage + ")\">" + " ▶" + "</a>";

		} else {

			pageEndLinkNo = pageCnt;

			nextPageSetBtn = "";

		}



		pageLinkArea = prevPageSetBtn + "<span style='font-size:9pt; font-family:굴림; color:#212863;'>[</span>";

		for (var i = pageStartLinkNo; i <= pageEndLinkNo; i++) {

			if (i != startPageNo) {

				pageLinkArea = pageLinkArea + "<a style='font-size:9pt; font-family:굴림; text-decoration:none; color:#212863; cursor:hand;' " +

				               "onclick=\"cfChangePagePeriod(" +

				               dataId + ", '" + action + "', '" + parameter + "', " + i +

				               ", " + confirmChangePage + ")\"> " + i + " </a>";

			} else {

				pageLinkArea = pageLinkArea + "<span style='font-size:9pt; font-family:굴림; color:#5C8BE0; font-weight:bold;'> " + i + " </span>";

			}

		}

		pageLinkArea = pageLinkArea + "<span style='font-size:9pt; font-family:굴림; color:#212863;'>]</span>" + nextPageSetBtn;

	}



	if (showTotal) {

		totalArea = "<span style='font-size:9pt; font-family:굴림; color:#212863;'>총건수: </span><span style='font-size:9pt; font-family:굴림; color:#5C8BE0; font-weight:bold'>"+ rsltCnt + "</span>";

	}



	if (showPageInfo) {

		pageInfoArea = "<span style='font-size:9pt; font-family:굴림; color:#212863;'>";

		if (showTotal == true) {

			pageInfoArea = pageInfoArea + "&nbsp;&nbsp;";

		}



		pageInfoArea = pageInfoArea +  "페이지: </span><span style='font-size:9pt; font-family:굴림; color:#5C8BE0; font-weight:bold;'>" + startPageNo + "/" + pageCnt + "</span>";

	}



	oGridHeader.innerHTML = "<table border=1 cellpadding='0' cellspacing='0' width='" + width + "'>" +

	                        "    <tr>" +

	                        "        <td align='left' width='1%' nowrap>" + totalArea + pageInfoArea + "</td>" +

	                        "        <td align='center'>" + pageLinkArea + "</td>" +

	                        "        <td align='right' width='30'>" + prevBtn + nextBtn + "</td>" +

	                        "        </td>" +

                            "    </tr>" +

                            "</table>";

}



/**

 * @type   : function

 * @access : public

 * @desc   : Grid의 DataId로 지정된 DataSet에 데이터가 0건일 경우에만 "데이터가 없습니다." 라는 메시지를 Grid상에 보여준다.

 *           데이터가 있을 경우에는 메시지가 보이지 않으며 기존에 이미 보여진 경우에는 메시지가 사라진다.<br>

 *           언제 호출하든지 상관없지만 보통 DataSet의 OnLoadCompleted 이벤트나 Transaction의 OnSuccess 이벤트에서 호출한다.

 * <pre>

 *     &lt;script language="javascript" for="oDelivRsltGDS" event="OnLoadCompleted()"&gt;

 *         cfFillGridHeader(oDelivRsltGGHeader, oDelivRsltGDS, "kpl.spl.common.svl.SplSVL", "kpl.spl.sb.fnc.cmd.RetrieveDelivRsltListCMD", "pageLinkCnt=3");

 *         <b>cfFillGridNoDataMsg(oDelivRsltGG, "gridColLineCnt=2");</b>

 *     &lt;/script&gt;

 * </pre>

 * @sig    : oGG[, features]

 * @param  : oGG      required Grid 오브젝트

 * @param  : features optional 기타 속성을 정의하는 스트링. 속성종류는 아래와 같다.

 * <pre>

 *     gridColLineCnt : Grid의 컬럼 줄의 수. 일반적으로는 한 줄이지만 Grid의 타이틀이 들어가면 2가 될 것이다. 기본값은 1이다.

 * </pre>

 * @author : GAUCE

 */

function cfFillGridNoDataMsg(oGG, features) {

	var oGDS = document.all(oGG.DataId);



	var featureNames  = ["gridColLineCnt"];

	var featureValues = [1];

	var featureTypes  = ["number"];



	if (features != null) {

		cfParseFeature(features, featureNames, featureValues, featureTypes);

	}



	var gridColLineCnt = featureValues[0];

	var oNoDataMsg = document.createElement("<OBJECT>");

	var colHeight = 20;

	var msgWidth = 105;

	var marginTop = 10;



	oNoDataMsg.classid           = "CLSID:E6876E99-7C28-43AD-9088-315DC302C05F";

	oNoDataMsg.width             = msgWidth;

	oNoDataMsg.Numeric           = false;

	oNoDataMsg.Border            = false;

	oNoDataMsg.Enable            = false;

	oNoDataMsg.DisabledBackColor = "#FFFFFF";

	oNoDataMsg.Text              = "데이터가 없습니다.";

	oNoDataMsg.style.fontSize    = "9pt";

	oNoDataMsg.style.position    = "absolute";

	oNoDataMsg.style.left        = Number(oGG.style.left.substring(0, oGG.style.left.length - 2)) +

	                               (Number(cfIsNull(oGG.width) ? oGG.style.width.substring(0, oGG.style.width.length - 2) : oGG.width) - 105) / 2;

	oNoDataMsg.style.top         = Number(oGG.style.top.substring(0, oGG.style.top.length - 2)) +

	                               gridColLineCnt * colHeight + marginTop;



	oGG.insertAdjacentElement("beforeBegin", oNoDataMsg);



	if (oGDS.CountRow == 0) {

		oGG.style.zIndex = 1;

		oNoDataMsg.style.zIndex = 2;

	} else {

		oGG.style.zIndex = 2;

		oNoDataMsg.style.zIndex = 1;

	}

}

/**

 * @type   : function

 * @access : public

 * @desc   : 서버에서 현재시간을 읽어와서 자바스크립트의 Date 오브젝트로 변환한다.

 *           Date 오브젝트로부터 스트링 형태로 날짜 혹은 시간을 얻으려면 Date.format() 메소드를 참조할 것.

 * @return : Date 오브젝트

 * @author : GAUCE

 */

function cfGetCurrentDate() {

	var dataSet;

	var dateString;



	if (document.all("coCurrentDateGDS") == null) {

		dataSet = document.createElement("<OBJECT>");

		dataSet.classid = "CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49";

		dataSet.id = "coCurrentDateGDS";

		dataSet.SyncLoad = "true";

		dataSet.DataId = getDNS() + "/servlet/kpl.ici.common.svl.IciIntroSVL?cmd=kpl.common.util.cmd.CurrentDateCMD";



		// </head> 태그 직전에 DataSet 삽입

		for (var i = 0; i < document.all.length; i++) {

			if (document.all[i].tagName == "HEAD") {

				document.all[i].insertAdjacentElement("beforeEnd", dataSet);

				break;

			}

		}

	} else {

		dataSet = document.all("coCurrentDateGDS");

	}



	dataSet.Reset();

	dateString = dataSet.NameValue(1, "dateString");

	dataSet.clearData();



	if (cfIsNull(dateString)) {

		return null;

	}



	return new Date(dateString.substr(0, 4),

	                Number(dateString.substr(4, 2)) -1,

	                dateString.substr(6, 2),

	                dateString.substr(8, 2),

	                dateString.substr(10, 2),

	                dateString.substr(12, 2)

	               )

}



/**

 * @type   : function

 * @access : public

 * @desc   : Element의 type을 알려준다. 리턴되는 element type string은 다음과 같다.

 * <pre>

 *     BUTTON   : html button input tag

 *     CHECKBOX : html checkbox input tag

 *     FILE     : html file input tag

 *     HIDDEN   : html hidden input tag

 *     IMAGE    : html image input tag

 *     PASSWORD : html password input tag

 *     RADIO    : html radio input tag

 *     RESET    : html reset input tag

 *     SUBMIT   : html submit input tag

 *     TEXT     : html text input tag

 *     SELECT   : html select tag

 *     TEXTAREA : html textarea tag

 *     GCC      : 가우스 CodeCombo

 *     GRDO     : 가우스 Radio

 *     GTA      : 가우스 TextArea

 *     GIF      : 가우스 InputFile

 *     GE       : 가우스 EMEdit

 *     GDS      : 가우스 DataSet

 *     GTR      : 가우스 Transaction

 *     GCHT     : 가우스 Chart

 *     GID      : 가우스 ImageData

 *     GG       : 가우스 Grid

 *     GTB      : 가우스 Tab

 *     GTV      : 가우스 TreeView

 *     GM       : 가우스 Menu

 *     GB       : 가우스 Bind

 *     GRPT     : 가우스 Report

 *     GS       : 가우스 Scale

 *     null     : 기타

 * </pre>

 * @sig    : oElement

 * @param  : oElement required element
 * @return : element의 type을 표현하는 string

 * @author : GAUCE

 */

function cfGetElementType(oElement) {

	if (oElement == null) {

		return null;

	}



	switch (oElement.tagName) {

		case "INPUT":

			switch (oElement.type) {

				case "button" :

					return "BUTTON";

				case "checkbox" :

					return "CHECKBOX";

				case "file" :

					return "FILE";

				case "hidden" :

					return "HIDDEN";

				case "image" :

					return "IMAGE";

				case "password" :

					return "PASSWORD";

				case "radio" :

					return "RADIO";

				case "reset" :

					return "RESET";

				case "submit" :

					return "SUBMIT";

				case "text" :

					return "TEXT";

				default :

					return null;

			}

		case "SELECT":

			return "SELECT"

		case "TEXTAREA":

			return "TEXTAREA"

		case "OBJECT":

			    switch (oElement.attributes.classid.nodeValue.toUpperCase()) {

				case "CLSID:FD4C6571-DD20-11D2-973D-00104B15E56F": // CodeCombo Component

					return "GCC"

				case "CLSID:14DA1FE5-438E-4E2C-959D-5BF03F63EA9C": // CodeCombo2 Component

					return "GCC"

				case "CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0": // Radio Component

					return "GRDO"

                case "CLSID:91B0A4F0-3206-4564-9BB4-AF9055DEF8A1": // TextArea Component

					return "GTA"

				case "CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03": // InputFile Component

					return "GIF"

				case "CLSID:E6876E99-7C28-43AD-9088-315DC302C05F": // EMedit Component

					return "GE"

				case "CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49": // DataSet Component

					return "GDS"

				case "CLSID:0A2233AD-E771-11D2-973D-00104B15E56F": // Transaction Component

					return "GTR"

				case "CLSID:B5F6727A-DD38-11D2-973D-00104B15E56F": // Chart Component

					return "GCHT"

				case "CLSID:BCB3A52D-F8E7-11D3-973E-0060979E2A03": // ImageData Component

					return "GID"

				case "CLSID:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49": // Grid Component

					return "GG"

				case "CLSID:ED382953-E907-11D3-B694-006097AD7252": // Tab Component

					return "GTab"

				case "CLSID:4401B994-DD33-11D2-B539-006097ADB678": // TreeView Component

					return "GTree"

				case "CLSID:7A54CBF0-2CB4-11D4-973E-0060979E2A03": // Menu Component

					return "GM"

				case "CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49": // Bind Component

					return "GB"

				case "CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F": // Report Component

					return "GRPT"

				case "CLSID:8D6D8F1E-2567-4916-8036-50D3F7F01563": // Scale Component

					return "GS"

                default:

                	return null;

			}

		default :

			return null;

	}

}



/**

 * @type   : function

 * @access : public

 * @desc   : 스트링의 자릿수를 Byte 단위로 환산하여 알려준다. 영문, 숫자는 1Byte이고 한글은 2Byte이다.(자/모 중에 하나만 있는 글자도 2Byte이다.)

 * @sig    : value

 * @param  : value required 스트링

 * @return : 스트링의 길이

 * @author : GAUCE

 */

function cfGetByteLength(value){

	var byteLength = 0;



	if (cfIsNull(value)) {

		return 0;

	}



	var c;



	for(var i = 0; i < value.length; i++) {

		c = escape(value.charAt(i));



		if (c.length == 1) {

			byteLength ++;

		} else if (c.indexOf("%u") != -1)  {

			byteLength += 2;

		} else if (c.indexOf("%") != -1)  {

			byteLength += c.length/3;

		}

	}



	return byteLength;

}



/**

 * @type   : function

 * @access : public

 * @desc   : 공통메세지에 정의된 메세지를 리턴한다.

 * <pre>

 * // 공통 메세지 영역

 * var MSG_NO_CHANGED        = "변경된 사항이 없습니다.";

 * var MSG_SUCCESS_LOGIN     = "@님 안녕하세요?";

 * ...

 * var message1 = cfGetMsg(MSG_NO_CHANGED);

 * var message2 = cfGetMsg(MSG_SUCCESS_LOGIN, ["홍길동"]);

 * </pre>

 * 위의 예에서 message2 의 값은 "홍길동님 안녕하세요?" 가 된다.

 * @sig    : msgId[, paramArray]

 * @param  : msgId      required common.js의 공통 메세지 영역에 선언된 메세지 ID

 * @param  : paramArray optional 메세지에서 '@' 문자와 치환될 데이터 Array. Array의 index와

 *           메세지 내의 '@' 문자의 순서가 일치한다. 치환될 데이터는 [] 사이에 콤마를 구분자로 하여 기술하면 Array 로 인식된다.

 * @return : 치환된 메세지 스트링

 * @author : GAUCE

 */

function cfGetMsg(msgId, paramArray) {

	return new coMessage().getMsg(msgId, paramArray);

}



/**

 * @type   : function

 * @access : public

 * @desc   : 서버에서 클라이언트로 DataSet의 pageInfo 컬럼을 이용해 파라미터를 전달했을 경우 클라이언트에서 파라미터를 얻는 함수이다.

 *           서버에서 임의의 파라미터를 넣는 방법은 Paging을 사용할 때와 비슷하다.<br>

 * <pre>

 *           1. 임의의 파라미터를 넣으려는 DataSet에 pageInfo 컬럼을 추가한다.

 *              dataSet.MakeDataSetInfo("pageInfo", gauceDefine.TB_STRING);

 *

 *           2. pageInfo 데이터를 조립하여 DataSet의 첫번째 row의 pageInfo컬럼에 pageInfo 정보를 삽입한다.

 *              ...

 *              if (dataSet.rowcnt() > 0) {

 *                  rec = dataSet.getRow(1);

 *                  StringBuffer pageInfo = new StringBuffer();

 *                  pageInfo.append("&p1=").append(p1)

 *                          .append("&p2=").append(p2)

 *                          ...

 *                          .append("&pn=").append(pn);

 *

 *                  rec.setString("pageInfo", pageInfo.toString());

 *              }

 *              ...

 *

 *           4. 화면에서 cfGetPageInfo 함수를 이용해 값을 꺼낸다.

 *              cfGetPageInfo(oDelivGDS);

 *              cfGetPageInfo(oDelivGDS, "p1");

 *              cfGetPageInfo(oDelivGDS, "p1", "default value");

 * </pre>

 * @sig    : oDataSet[, paramName[, defaultValue]]

 * @param  : oDataSet     required pageInfo 가 들어있는 DataSet
 * @param  : paramName    optional pageInfo 중에서 얻고자 하는 파라미터의 이름
 * @param  : defaultValue optional paramName에 해당하는 파라미터가 존재하지 않을 경우 리턴되는 기본값.
 * @return : paramName이 없을 경우에는 pageInfo 스트링 전체를 리턴하고 paramName이 있을 경우는 해당 파라미터의 값을 리턴한다.

 * @author : GAUCE

 */

function cfGetPageInfo(oDataSet, paramName, defaultValue) {

	var pageInfo;


alert("CountRow : "+  oDataSet.CountRow);

	if (oDataSet.CountRow != 0) {

alert("pageInfo : " + oDataSet.NameValue(1, "pageInfo"));
alert(cfIsNull(pageInfo = oDataSet.NameValue(1, "pageInfo")));

		if (cfIsNull(pageInfo = oDataSet.NameValue(1, "pageInfo"))) {

alert("pageInfo : " + pageInfo);


			for (var i = 2; i <= oDataSet.CountRow; i++) {

				if (!cfIsNull(oDataSet.NameValue(i, "pageInfo"))) {

					pageInfo = oDataSet.NameValue(i, "pageInfo");

					alert("pageInfo : " + pageInfo);

					break;

				}

			}

		}

	}

alert(cfIsNull(paramName));

	if (cfIsNull(paramName)) {

		return pageInfo;

	}



	if (cfIsNull(pageInfo)) {

		return defaultValue;

	}



	var paramArray = pageInfo.advancedSplit("&", "i");

	var paramPair;



	for (var i = 0; i < paramArray.length; i++) {

		paramPair = paramArray[i].advancedSplit("=", "it");



		if (paramPair[0] == paramName.trim()) {

			return paramPair[1];

		}

	}



	return defaultValue;

}



/**

 * @type   : function

 * @access : public

 * @desc   : 한번 검색된 DataSet의 DataId에 지정되어 있는 파라미터 스트링을 얻기 위한 함수. 주로 페이징을

 *           사용할 때 사용된다.

 * <pre>

 *    var action = "/servlet/kpl.spl.common.svl.SplSVL?cmd=kpl.spl.sb.fnc.cmd.RetrieveDelivRsltListCMD";

 *    var param  = "&delivYmd=" + oDelivYmd.Text +

 *        "&delivSeqCd=" + oDelivSeqCd.CodeValue +

 *        "&pageSize=8" +

 *        "&pageNo=1";

 *

 *    oDelivRsltGDS.DataId = action + param;

 *    oDelivRsltGDS.Reset();

 * </pre>

 * 위와 같이 DataId 를 작성하여 DataSet을 검색하였다고 하자. 이 때 oDelivYmd.Text 의 값은 "20020913" 이었고

 * oDelivSeqCd.CodeValue 의 값은 "001" 이었다고 할 경우, parameter 로 사용된 스트링 부분을

 * 다시 얻기 위해서는 아래와 같이 하면 된다.

 * <pre>

 *     var param = cfGetPageParameter(oDelivRsltGDS);

 * </pre>

 * 위에서 param 의 값은 "&delivYmd=20020913&delivSeqCd=001&pageSize=8&pageNo=1" 이 된다.

 * @sig    : oDataSet

 * @param  : oDataSet required parameter string을 얻고자 하는 DataSet 객체.

 * @author : GAUCE

 */

function cfGetPageParameter(oDataSet) {

	if (oDataSet.DataId.indexOf("&") != -1) {

		return parameter = oDataSet.DataId.substr(oDataSet.DataId.indexOf("&"));

	}



	return "";

}



/**

 * @type   : function

 * @access : public

 * @desc   : popup에서 radio button 변경시 처리

 * @sig    : oTypeGR, oStartPageNo, oEndPageNo

 * @param  : oTypeGR - radio button object id

 * @param  : oStartPageNo - start page를 나타낼 emedit object id

 * @param  : oEndPageNo -  end page를 나타낼 emedit object id

 * @author : GAUCE

 */

function cfGRadioChg(oTypeGR, oStartPageNo, oEndPageNo){

	if (oTypeGR.CodeValue =='1' ){

		oEndPageNo.ReadOnly   	= true;

		oStartPageNo.ReadOnly 	= true;

		oStartPageNo.text	= 1;

		oEndPageNo.text		= page_cnt.innerText;

	}

	else{

		oEndPageNo.ReadOnly   = false;

		oStartPageNo.ReadOnly = false;

	}

}



/**

 * @type   : function

 * @access : private

 * @desc   : Object를 초기화한다.

 * @sig    : obj[, iniVal]

 * @param  : parentObj required 초기화할 대상 오브젝트

 * @param  : iniVal    optional 초기값

 * @author : 김봉근

 */

function cfIniObject(obj) {

	var	iniVal = "";



	switch (obj.tagName) {

		case "INPUT":

			switch (obj.type) {

				case "checkbox":

					obj.checked = 0;

					break;

				case "button" :

					break;

				case "image" :

					break;

				default :

					obj.value = "";

					break;

			}



			break;



		case "SELECT":

			obj.selectedIndex = 0;

			break;

		case "TEXTAREA":

			obj.value = "";

			break;



		case "OBJECT":

			switch (obj.attributes.classid.nodeValue.toUpperCase()) {

				case "CLSID:FD4C6571-DD20-11D2-973D-00104B15E56F": // CodeCombo Component

					obj.Index = 0;

                    break;

				case "CLSID:14DA1FE5-438E-4E2C-959D-5BF03F63EA9C": // CodeCombo2 Component

					obj.Index = 0;

                    break;

				case "CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0": // Radio Component

				case "CLSID:E6876E99-7C28-43AD-9088-315DC302C05F": // EMedit Component

                case "CLSID:91B0A4F0-3206-4564-9BB4-AF9055DEF8A1": // TextArea Component

					obj.Text = "";

					break;

				case "CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03": // InputFile Component

                    break;

                default :

                	break;

			}

	}

}



/**

 * @type   : function

 * @access : public

 * @desc   : 사용자가 누른 key가 enter key 인지 여부를 알려준다.

 * <pre>

 *     function fncOnKeyPress() {

 *         ...

 *         if (cfIsEnterKey()) {

 *             ...

 *         }

 *     }

 *     ...

 *     &lt;input type="text" onkeypress="fncOnKeyPress()"&gt;

 * </pre>

 * @return : enter key 여부

 * @author : GAUCE

 */

function cfIsEnterKey() {

	if (event.keyCode == 13) {

		return true;

	}



	return false;

}



/**

 * @type   : function

 * @access : public

 * @desc   : 값이 null 이거나 white space 문자로만 이루어진 경우 true를 리턴한다.

 * <pre>

 *     cfIsNull("  ");

 * </pre>

 * 위와같이 사용했을 경우 true를 리턴한다.

 * @sig    : value

 * @param  : value required 입력값
 * @return : boolean. null(혹은 white space) 여부

 * @author : GAUCE

 */

function cfIsNull(value) {

	if (value == null ||

	    (typeof(value) == "string" && value.trim() == "")

	   ) {

		return true;

	}



	return false;

}



/**

 * @type   : function

 * @access : public

 * @desc   : 값이 지정된 그룹내에 존재하는지를 알려준다.

 * <pre>

 *     cfIsIn(3, [1, 2, 3]);                     // -> true

 *     cfIsIn(3, [4, 5, 6]);                     // -> false

 *     cfIsIn('F', ['A', 'B', 'F']);             // -> true

 *     cfIsIn('F', ['A', 'B', 'C']);             // -> false

 *     cfIsIn("lim", ["lim", "kim", "park"]);    // -> true

 *     cfIsIn("lim", ["lee", "kim", "park"]);    // -> false

 * </pre>

 * @sig    : value, valueArray

 * @param  : value      required 비교하고 싶은 값
 * @param  : valueArray required 비교하고 싶은 값에 대한 비교 대상이 되는 값들의 집합. array 타입이며 array

 *           내의 각 element의 데이터 타입은 value 파라미터의 타입과 일치해야 한다.

 * @return : boolean. 값이 지정된 그룹내에 존재하는지 여부.
 * @author : GAUCE

 */

function cfIsIn(value, valueArray) {

	for (var i = 0; i < valueArray.length; i++) {

		if (value == valueArray[i]) {

			return true;

		}

	}



	return false;

}



/**

 * @type   : function

 * @access : public

 * @desc   : 페이지가 다른 페이지로부터 로드된 페이지인지 여부를 알려준다.

 * @sig    : pageId

 * @param  : pageId required 현재 페이지 id
 * @author : GAUCE

 */

function cfIsNaviPage(pageId) {

	if (GLB_FRAME_MAIN_NAVI.receivePageId != null && GLB_FRAME_MAIN_NAVI.receivePageId == pageId) {

		return true;

	}



	return false;

}



/**

 * @type   : function

 * @access : public

 * @desc   : 페이지를 이동할 때 파라미터 및 DataSet을 전달하기 위한 함수.

 * <pre>

 *     in.html 페이지에서 out.html 로 페이지를 이동하면서 2개의 파라미터와 2개의 DataSet을 전달하고자 한다.

 *     전달할 파라미터는 param1과 param2이며 전달할 DataSet의 id는 각각 oPmanGDS 와 oDAreaGDS 이다.

 *     이 때 in.html 에서 수행해야 될 절차는 다음과 같다.

 *

 *         1. coParameterMap 객체를 생성한다. (coParameterMap 객체에 대한 설명은 document를 참조)

 *            var paramMap = new coParameterMap();

 *

 *         2. coParameterMap 객체에 전달할 파라미터 데이터를 채운다.

 *	          paramMap.put("param1", "paramvalue1");

 *            paramMap.put("param2", "paramvalue2");

 *

 *         3. cfNaviPageIn 함수를 호출한다.

 *            cfNaviPageIn("out.html", paramMap, "pman=oPmanGDS,dArea=oDAreaGDS");

 *

 *            <font color=red>

 *            ※주의 : 이 함수는 전체 화면에 대한 프레임 구조가 제대로 로드되어 있지 않으면에러가 난다.

 *                     따라서 에러가 날 경우 시스템 초기화면부터 제대로 로드된 상태인지 확인해 보기 바란다.

 *            </font>

 * </pre>

 * @sig    : receivePageId, paramMap[, dataSetKeyValue]

 * @param  : receivePageId   required 전달할 페이지의 id(.html을 제외한 파일명과 동일)
 * @param  : paramMap        required 전달할 파라미터를 담고 있는 coParameterMap 객체
 * @param  : dataSetKeyValue optional 전달할 DataSet에 대한 정보를 형식에 맞게 표현한 스트링.

 * <pre>

 *     형식 : "key=dataset_id, ..."

 *     예   : "pman=oPmanGDS,dArea=oDAreaGDS"

 * </pre>

 * @author : GAUCE

 */

function cfNaviPageIn(receivePageId, paramMap, dataSetKeyValue) {

	// MainNaviFrame의 head element 찾기

	var head;

	for (var i = 0; i < GLB_FRAME_MAIN_NAVI.document.all.length; i++) {

		if (GLB_FRAME_MAIN_NAVI.document.all[i].tagName == "HEAD") {

			head = GLB_FRAME_MAIN_NAVI.document.all[i];

			break;

		}

	}



	// clear navigation data

	{

		// remove receivePageId

		GLB_FRAME_MAIN_NAVI.receivePageId = null;



		// remove parameterForm

		if (GLB_FRAME_MAIN_NAVI.parameterForm != null) {

			GLB_FRAME_MAIN_NAVI.document.body.removeChild(GLB_FRAME_MAIN_NAVI.parameterForm);

		}



		// MainNaviFrame의 head 내의 모든 DataSet 삭제

		for (var i = 0; i < head.children.length; i++) {

			if (head.children[i].tagName == "OBJECT" &&

			    head.children[i].attributes.classid.nodeValue.toUpperCase() == "CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" // DataSet Object

			   ) {

				head.removeChild(head.children[i]);

			}

		}

	}



	// initialize navigation data

	{

		// set receivePageId

		GLB_FRAME_MAIN_NAVI.receivePageId = receivePageId;



		// create parameterForm

		parameterForm = document.createElement("<FORM>");

		parameterForm.id = "parameterForm";

		GLB_FRAME_MAIN_NAVI.document.body.insertAdjacentElement("beforeEnd", parameterForm);

	}



	// MainNaviFrame 에 navigation을 위한 parameter 만들기

	if (paramMap != null) {

		var paramObj

		for (var i = 0; i < paramMap.size(); i++) {

			paramObj = document.createElement("<INPUT>");

			paramObj.name = paramMap.getNameAt(i);

			paramObj.value = paramMap.getValueAt(i);

			GLB_FRAME_MAIN_NAVI.parameterForm.insertAdjacentElement("beforeEnd", paramObj);

		}

	}



	if (!cfIsNull(dataSetKeyValue)) {

		var keyValueArray = dataSetKeyValue.split(",");

		var keyValuePair;

		var key;

		var value;

		var originDataSet;

		var dataSet;



		for (var i = 0; i < keyValueArray.length; i++) {

			keyValuePair = keyValueArray[i].trim().split("=");

			key = keyValuePair[0].trim();

			value = keyValuePair[1].trim();



			// 복사용 DataSet 만들기

			dataSet = document.createElement("<OBJECT>");

			dataSet.classid = "CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49";

			dataSet.id = key;

			head.insertAdjacentElement("beforeEnd", dataSet);



			// 복사용 DataSet에 데이터 넣기

			originDataSet = document.all(value);

			cfCopyDataSet(originDataSet, dataSet);

		}

	}



	location.href = receivePageId + ".html";

}



/**

 * @type   : function

 * @access : public

 * @desc   : 페이지를 이동할 때 파라미터 및 DataSet을 전달받기 위한 함수. cfNaviPageIn 함수에 대한 설명을 다 이해하였다고 가정한다.

 * <pre>

 *     in.html 로부터 out.html 페이지로 이동하면서 2개의 파라미터와 2개의 DataSet을 전달하고자 한다. 전달할 파라미터는 param1과 param2이며

 *     전달할 DataSet의 id는 각각 oPmanGDS 와 oDAreaGDS 이다. 이 때 out.html에서 수행해야 될 절차는 다음과 같다.

 *

 *         1. 전달받아야 할 DataSet을 담는 DataSet이 선언되어 있어야 한다. 즉, in.html에서 전달되는 두 개의 DataSet(oPmanGDS, oDAreaGDS)을

 *            담을 수 있는 두 개의 DataSet이 선언되어 있어야 한다. (여기서는 oPmanOutGDS과 oDAreaOutGDS 라고 가정한다.)

 *

 *         2. body의 onload 이벤트 발생시 다음과 같이 처리해 준다.

 *            1) cfIsNaviPage 함수(document를 참조) 를 이용해서 현재 페이지가 다른 페이지를 통해 로드된 것인지,

 *               아니면 그냥 메뉴를 선택해서 로드된 것인지 확인한다.

 *

 *		         if (cfIsNaviPage("out")) {

 *                   ...

 *               }

 *

 *            2) 만일 다른 페이지(in.html)를 통해 로드된 것이라면 cfNaviPageOut 함수를 호출한다.

 *

 *               var paramMap = cfNaviPageOut("out", "pman=oPmanOutGDS,dArea=oDAreaOutGDS");

 *              (이 때, 두번째 파라미터의 key 값은(pman, dArea) in.html에서 사용한 key 값과 동일해야 한다.)

 *

 *            3) 만일 이전 페이지에서 파라미터를 넘겼다면 paramMap 변수에는 coParameterMap 객체(document 참조할것) 를 리턴받을 것이다.

 *               전달받은 파라미터는 paramMap 변수를 이용해서 사용하면 된다.

 *               또한 전달받은 DataSet은 1번에서 선언한 DataSet에 담겨있을 것이다.

 * </pre>

 * @sig    : pageId[, dataSetKeyValue]

 * @param  : pageId          required 현재 페이지의 id(.html을 제외한 파일명과 동일)
 * @param  : dataSetKeyValue optional 전달받는 DataSet에 대한 정보를 형식에 맞게 표현한 스트링.

 * <pre>

 *     형식 : "key=dataset_id, ..."

 *     예   : "pman=oPmanGDS,dArea=oDAreaGDS"

 *     <font color=red>※주의</font> : 이 때 key 값은 in.html에서 cfNaviPageIn 함수의 dataSetKeyValue 파라미터 작성시 사용했던 key와 동일해야 한다.

 * </pre>

 * @return : 넘겨받은 파라미터가 있을 경우 그 파라미터정보를 담고 있는 coParameter 객체가 리턴된다.

 * @author : GAUCE

 */

function cfNaviPageOut(pageId, dataSetKeyValue) {

	if (GLB_FRAME_MAIN_NAVI.receivePageId == null || GLB_FRAME_MAIN_NAVI.receivePageId != pageId) {

		return null;

	}



	if (!cfIsNull(dataSetKeyValue)) {

		var keyValueArray = dataSetKeyValue.split(",");

		var keyValuePair;

		var key;

		var value;

		var originDataSet;

		var dataSet;



		for (var i = 0; i < keyValueArray.length; i++) {

			keyValuePair = keyValueArray[i].trim().split("=");

			key = keyValuePair[0].trim();

			value = keyValuePair[1].trim();



			// 복사용 DataSet에 데이터 넣기

			originDataSet = GLB_FRAME_MAIN_NAVI.document.all(key);

			cfCopyDataSet(originDataSet, document.all(value));

		}

	}



	// MainNaviFrame 으로부터 navigation을 위한 parameter 들을 읽어서 coParameterMap 객체로 만들기

	var paramMap = new coParameterMap();

	var parameters = GLB_FRAME_MAIN_NAVI.parameterForm.children;

	for (var i = 0; i < parameters.length; i++) {

		paramMap.put(parameters[i].name, parameters[i].value);

	}



	// clear navigation data

	{

		// remove parameterForm

		GLB_FRAME_MAIN_NAVI.document.body.removeChild(GLB_FRAME_MAIN_NAVI.parameterForm);



		// remove receivePageId

		GLB_FRAME_MAIN_NAVI.receivePageId = null;



		var head;



		// MainNaviFrame의 head element 찾기

		for (var i = 0; i < GLB_FRAME_MAIN_NAVI.document.all.length; i++) {

			if (GLB_FRAME_MAIN_NAVI.document.all[i].tagName == "HEAD") {

				head = GLB_FRAME_MAIN_NAVI.document.all[i];

				break;

			}

		}



		// MainNaviFrame의 head 내의 모든 DataSet 삭제

		for (var i = 0; i < head.children.length; i++) {

			if (head.children[i].tagName == "OBJECT" &&

			    head.children[i].attributes.classid.nodeValue.toUpperCase() == "CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" // DataSet Object

			   ) {

				head.removeChild(head.children[i]);

			}

		}

	}



	return paramMap;

}



/**

 * @type   : function

 * @access : public

 * @desc   : window.open으로 서브창을 띄울 때 서브창의 위치를 간단하게 지정할 수 있다.

 * @sig    : width, height, position, [sURL] [, sName] [, sFeatures] [, bReplace]

 * @param  : width - 서브창의 넓이

 * @param  : height - 서브창의 높이

 * @param  : position  - 서브창의 위치 (default : 5) <br><br>

 * <table border='1'>

 *     <tr>

 *         <td>1</td>

 *         <td>2</td>

 *         <td>3</td>

 *     </tr>

 *     <tr>

 *         <td>4</td>

 *         <td>5</td>

 *         <td>6</td>

 *     </tr>

 *     <tr>

 *         <td>7</td>

 *         <td>8</td>

 *         <td>9</td>

 *     </tr>

 * </table>

 * @param  : sURL      required window.open의 sURL 파라미터와 동일

 * @param  : sName     required window.open의 sName 파라미터와 동일

 * @param  : sFeatures required window.open의 sFeatures 파라미터와 동일

 * @param  : bReplace  required window.open의 bReplace 파라미터와 동일

 * @author : GAUCE

 */

function cfOpen(width, height, position, sURL, sName, sFeatures, bReplace) {

	var left = 0;

	var top = 0;



/*

	var featureNames  = ["status", "menubar", "toolbar"];

	var featureValues = ["no", "no", "no"];

	var featureTypes  = ["boolean", "boolean", "boolean"];



	if (sFeatures != null) {

		cfParseFeature(sFeatures, featureNames, featureValues, featureTypes);

	}



	var status = featureValues[0];

	var menubar = featureValues[1];

	var toolbar = featureValues[2];

*/

	if (width != null && height != null) {

		width = width + 10; // window의 좌우 border 5px씩 감안.

		height = height + 29; // titlebar는 기본으로 감안.

/*

		if (status) {

			height = height + 20;

		}



		if (menubar) {

			height = height + 48;

		}



		if (toolbar) {

			height = height + 27;

		}

*/

		switch (position) {

			case 1 :

				left = 0;

				top = 0;

				break;



			case 2 :

				left = (screen.availWidth - width) / 2;

				top = 0;

				break;



			case 3 :

				left = screen.availWidth - width;

				top = 0;

				break;



			case 4 :

				left = 0;

				top = (screen.availHeight - height) / 2;

				break;



			case 5 :

				left = (screen.availWidth - width) / 2;

				top = (screen.availHeight - height) / 2;

				break;



			case 6 :

				left = screen.availWidth - width;

				top = (screen.availHeight - height) / 2;

				break;



			case 7 :

				left = 0;

				top = screen.availHeight - height;

				break;



			case 8 :

				left = (screen.availWidth - width) / 2;

				top = screen.availHeight - height;

				break;



			case 9 :

				left = screen.availWidth - width;

				top = screen.availHeight - height;

				break;



			default :

				left = (screen.availWidth - width) / 2;

				top = (screen.availHeight - height) / 2;

				break;

		}



		if (cfIsNull(sFeatures)) {

			sFeatures = sFeatures + "left=" + left + ",top=" + top;

		} else {

			sFeatures = sFeatures + ",left=" + left + ",top=" + top;

		}

	}



	window.open(sURL, sName, sFeatures, bReplace);

}



/**

 * @type   : function

 * @access : private

 * @desc   : features 스트링을 파싱하여 array에 셋팅하는 내부 함수

 * @sig    : features, fNameArray, fValueArray, fTypeArray

 * @param  : features    required features를 표현한 스트링

 * @param  : fNameArray  required 추출해야 할 feature의 이름에 대한 array

 * @param  : fValueArray required 추출해야 할 feature의 기본값에 대한 array

 * @param  : fTypeArray  required 추출해야 할 feature의 데이터타입에 대한 array

 * @author : GAUCE

 */

function cfParseFeature(features, fNameArray, fValueArray, fTypeArray) {

	if (features == null) {

		return;

	}



	var featureArray = features.split(",");

	var featurePair;



	for (var i = 0; i < featureArray.length; i++) {

		featurePair = featureArray[i].trim().split("=");



		for (var j = 0; j < fNameArray.length; j++) {

			if (featurePair[0] == fNameArray[j]) {

				switch (fTypeArray[j]) {

					case "string" :

						fValueArray[j] = featurePair[1];

						break;

					case "number" :

						fValueArray[j] = Number(featurePair[1]);

						break;

					case "boolean" :

						if (featurePair[1].toUpperCase() == "YES" || featurePair[1].toUpperCase() == "TRUE" || featurePair[1] == "1") {

							fValueArray[j] = true;

						} else {

							fValueArray[j] = false;

						}

						break;

				}

			}

		}

	}

}



/**

 * @type   : function

 * @access : public

 * @desc   : 보고서 popup에서 전체 레코드수/페이지수, 출력가능 수량을 셋팅한다.

 * @sig    : oPagePrintMsg, oTypeGR, oStartPageNo, oEndPageNo

 * @param  : oPagePrintMsg - 총건수/페이지정보를 나타낼 div tag id

 * @param  : oTypeGR - radio button object id

 * @param  : oStartPageNo - start page를 나타낼 emedit object id

 * @param  : oEndPageNo -  end page를 나타낼 emedit object id

 * @author : 조부구

 */

function cfPrintPopupSetting(oPagePrintMsg, oTypeGR, oStartPageNo, oEndPageNo){


/* 2003.05.22 페이지에 대한 제약기능삭제
		oPagePrintMsg.innerHTML =

			"<table width='300' style='position:absolute; left:'30'; top:'170'; cellspacing='0' cellpadding='0'>"+

			"<tr><td align='left'><font id='oMaxPage' style='font-size:9pt; font-family:굴림; color:#5C8BE0; font-weight:bold;'><font></td>"+

			"<td><font  style='font-size:9pt; font-family:굴림; color:#212863; font-weight:bold;'><font>&nbsp페이지 이상은 출력할수 없습니다.</td></tr></table>";





		//oTypeGR : gauce radio button object id,oStartPageNo : gauce emedit startpage id, oEndPageNo : gauce emedit endpage id

		oMaxPage.innerText = GLB_REPORT_MAXPAGE; //페이지 출력시 주의 페이지 수량

*/

		Parm = window.dialogArguments;



		DSDataid     = Parm.DataId;   //dataset dataid

		pageInfo     = Parm.PageInfo; //page



		cfFillGridHeaderPage(oRegistGGHeader,pageInfo);



		//page_cnt.innerText page수

		//GLB_REPORT_MAXPAGE  최대가능 page수

		if( page_cnt.innerText < GLB_REPORT_MAXPAGE ){

			//최대 페이지보다 실제 페이지가 작은경우 전체출력가능

			oTypeGR.CodeValue     = 1;

			oStartPageNo.text     = 1;

			oEndPageNo.text       = page_cnt.innerText;

			oEndPageNo.ReadOnly   = true;

			oStartPageNo.ReadOnly = true;

		}

		else{

			//최대 페이지보다 실제 페이지가 큰경우 부분출력가능

			oStartPageNo.text     = 1;

			oEndPageNo.text       = 100;

			oTypeGR.CodeValue 	  = 2;

			oTypeGR.Enable    	  = false;

		}

}



/**

 * @type   : function

 * @access : private

 * @desc   : html상에서 parent element에 대한 child element 들에 대해 일괄적으로 동일한 함수를 수행시킨다.

 * @sig    : parentObj, fnc[, argArr]

 * @param  : parentObj required parent object

 * @param  : fnc required 각 input element 마다 수행시킬 함수 포인터

 * @param  : argArr optional 함수에 전달할 파라미터. 이 메소드를 통해 호출되는 함수는 무조건 두 개의 파라미터로만

 *           구성되어야 한다. 하나는 처리하려는 element, 나머지 하나는 처리시 필요한 파라미터들의 array 객체이다.

 * @author : GAUCE

 */

function cfProcessChildElement(parentObj, fnc, argArr) {

	fnc(parentObj, argArr);



	if (parentObj.all == null) {

		return;

	}



	for (var i = 0; i < parentObj.all.length; i++) {

		fnc(parentObj.all[i], argArr);

	}

}



/**

 * @type   : function

 * @access : public

 * @desc   : 공통메세지에 정의된 메세지를 prompt box 로 보여준다. 만약 패스워드를 입력받는 prompt box를

 *           띄우면서 공통메세지에 정의된 메세지를 보여주고 싶다면 다음과 같이 하면 된다.

 * <pre>

 *     // 공통메세지 영역

 *     var MSG_INPUT_PASSWORD = "@님, 패스워드를 입력하십시오.";

 *     ...

 *     cfPromptMsg(MSG_INPUT_PASSWORD, ["홍길동"], "입력하세요.");

 * </pre>

 * @sig    : msgId[, paramArray[, defaultVal]]

 * @param  : msgId      required common.js의 공통 메세지 영역에 선언된 메세지 ID

 * @param  : paramArray optional 메세지에서 '@' 문자와 치환될 스트링 Array. (Array의 index와

 *           메세지 내의 '@' 문자의 순서가 일치한다.)

 * @param  : defaultVal optional prompt box 의 입력필드에 보여줄 기본값.

 * @return : 입력받은 String 혹은 Integer 타입의 패스워드 데이터

 * @author : GAUCE

 */

function cfPromptMsg(msgId, paramArray, defaultVal) {

	if (cfIsNull(msgId)) {

		alert("존재하지 않는 메시지입니다.");

		return null;

	}



	return prompt(new coMessage().getMsg(msgId, paramArray), defaultVal);

}



/**

 * @type   : function

 * @access : public

 * @desc   : parent object (Div, Table, FieldSet 태그)에 속한 모든 child object의 값을 초기화한다.

 * @sig    : parentObj[, iniVal]

 * @param  : parentObj required 초기화할 부모 오브젝트

 * @param  : iniVal    optional 초기값

 * @author : 김수호

 */

function cfReset(parentObj, iniVal) {

	cfProcessChildElement(parentObj, cfIniObject);

}



/**

 * @type   : function

 * @access : public

 * @desc   : Paging 을 사용하는 DataSet을 Transaction 을 이용해서 조회해 올 경우에 조회된 후에도 Paging 이 제대로

 *           동작하기 위해서는 Transaction 수행 전에 해당 DataSet의 Paging에 필요한 파라미터들을 미리 저장해 두어야 한다.

 *           그 때 이 함수를 사용한다. 페이징과 관련된 설명은 화면개발가이드를 참고할 것.

 * <pre>

 *      예) oDelivRsltGTR 오브젝트를 통해 Transaction 처리를 하고자 할 때 Transaction을 통해 oDelivRsltGDS DataSet을 읽어오고,

 *          oDelivRsltGDS DataSet이 페이징을 사용해야 하는 경우 아래와 같이 파라미터를 Post() 전에 저장한다.

 *

 *      ...

 *      <b>

 *      var pageParam = "/servlet/kpl.spl.common.svl.SplSVL?cmd=kpl.spl.sb.fnc.cmd.RetrieveDelivRsltListCMD" +

 *                      "&delivYmd=" + oDelivYmd.Text +

 *                      "&delivSeqCd=" + oDelivSeqCd.CodeValue +

 *                      "&sortBy=" + oSortBy.CodeValue +

 *                      "&delivAreaCd=" + oDelivAreaCd.CodeValue +

 *                      "&pageSize=8" +

 *                      "&pageNo=1";

 *

 *      cfSavePageParameter(oDelivRsltGDS, pageParam);

 *      </b>

 *      oDelivRsltGTR.Post();

 * </pre>

 * @sig    : oDataSet, parameter

 * @param  : oDataSet required DataSet 오브젝트

 * @param  : parameter required DataSet의 Paging에 필요한 파라미터를 표현하는 스트링

 * @author : GAUCE

 */

function cfSavePageParameter(oDataSet, parameter) {

	GLB_PAGE_PARAMS.put(oDataSet.id, parameter);

}



/**

 * @type   : function

 * @access : public

 * @desc   : Grid를 전체선택한다.

 * <pre>

 *     cfSelectAllGridRows(oDomRegiRecevGDS, oDomRegiRecevGG);

 * </pre>

 * 위의 예에서 oDomRegiRecevGDS 라는 id를 가진 DataSet의 데이터를 보여주는

 * oDomRegiRecevGG 라는 id를 가진 Grid 상에서 모든 Row들을 선택한다.

 * @sig    : dataSet, grid

 * @param  : dataSet required DataSet 오브젝트의 id

 * @param  : grid    required Grid 오브젝트

 * @author : GAUCE

 */

function cfSelectAllGridRows(oDataSet, oGrid) {

	oDataSet.MarkAll();

	oGrid.Focus();

}



/**

 * @type   : function

 * @access : public

 * @desc   : 공통으로 사용하는 달력창을 띄운다.

 * <pre>

 * 1. EMEdit와 함께 사용할 경우

 *     &lt;object id="calendarText" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F" width="100"&gt;

 *         &lt;param name="Alignment" value="1"&gt;

 *         &lt;param name="format" value="YYYY-MM-DD"&gt;

 *     &lt;/object&gt;

 *

 *     &lt;input type="button" value="달력띄우기" onclick="cfShowCalendar(calendarText)"&gt;

 * 2. Grid와 함께 사용할 경우

 *     ...

 *

 *     &lt;script language="javascript"  for=<b>"oGG"</b> event=<b>"OnPopup(Row, Colid, data)"</b>&gt;

 *         <b>cfShowCalendar(oCalendarGG);</b>

 *     &lt;/script&gt;

 *

 *     ...

 *

 *     &lt;!-- Grid Component ( 배달결과조회 ) --&gt;

 *     &lt;object id=<b>"oGG"</b> classid="CLSID:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" width="250" height="100"&gt;

 *         &lt;param name="DataID"         value=<b>"oGDS"</b>&gt;

 *         &lt;param name="Editable"       value="true"&gt;

 *         &lt;param name="Format"         value='

 *     	       &lt;C&gt; ID="delivYmd",    Name="배달일자", Width="100", <b>EditStyle="Popup", Mask="XXXX-XX-XX"</b>&lt;/C&gt;

 *     	       &lt;C&gt; ID="recPrsnName", Name="수령인",   Width="70"&lt;/C&gt;

 *             ...

 *     	   '&gt;

 *     &lt;/object&gt;

 *

 * </pre>

 * @sig    : item[, month[, year[, format]]]

 * @param  : item   required 달력창으로부터 선택된 날짜를 Text값으로 가지는 EMEdit 컴포넌트 혹은 Grid 오브젝트.

 * @param  : month  optional 달을 나타내는 숫자 (1~12).

 * @param  : year   optional 년도를 나타내는 4자리 숫자

 * @param  : format optional 날짜를 표현하는 형식을 나타내는 포멧 스트링. item 오브젝트의 Text값으로

 *                    셋팅되는 값의 format을 나타낸다. 기본값은 YYYYMMDD 이다.

 *                    Date 오브젝트의 format 메소드의 파라미터와 형식이 같으므로 참고할 것.

 * @author : GAUCE

 */

function cfShowCalendar(oItem, month, year, format) {

	var currDate = new Date();



	if (cfIsNull(month)) {

		month = currDate.getMonth() + 1;

	}



	if (cfIsNull(year)) {

		year = currDate.getFullYear();

	}



	if (cfIsNull(format)) {

		format = "YYYYMMDD";

	}



	if (oItem.tagName == "OBJECT" &&

	    oItem.attributes.classid.nodeValue.toUpperCase() == "CLSID:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" // Grid

	   ) {

		GLB_CALENDAR.eventSrc = oItem;

	} else {

		GLB_CALENDAR.eventSrc = event.srcElement;

	}



	GLB_CALENDAR.oItem = oItem.id;

	GLB_CALENDAR.month = month;

	GLB_CALENDAR.year = year;

	GLB_CALENDAR.format = format;



	var dwn = document.createElement("DOWNLOAD");

	dwn.style.behavior="url(#default#download)";


        if ( checkCrossFrame() ) {

	   dwn.startDownload( "c:/eKPLS/common/" + "calendar.html", cfOnDoneDownLoadCalendar);

	} else {

           dwn.startDownload(GLB_URL_COMMON_PAGE + "calendar.html", cfOnDoneDownLoadCalendar);
	}

}



function cfOnDoneDownLoadCalendar(src) {

	GLB_CALENDAR.popup = window.createPopup();

    GLB_CALENDAR.popup.document.write(src);



	GLB_CALENDAR.popup.document.all("oItem").value = GLB_CALENDAR.oItem;

	GLB_CALENDAR.popup.document.all("oMonth").value = GLB_CALENDAR.month - 1;

	GLB_CALENDAR.popup.document.all("oYear").value = GLB_CALENDAR.year;

	GLB_CALENDAR.popup.document.all("oFormat").value = GLB_CALENDAR.format;

	GLB_CALENDAR.popup.document.all("oRefreshBtn").fireEvent("onclick");

    GLB_CALENDAR.popup.show(0, 0, 192, 201, GLB_CALENDAR.eventSrc);

}



////////////////////////////////////////////////////////
// login_sso.jsp 관련 함수 추가
  function checkIsPopUpWindow() {

   // BodyFrame 의 top.opener 는 모두 NOT_POPUP_WINDOW 임
   // CrossFrame 이 BodyFrame 이었을 경우 top.opener 접근 불가

   var popupWinIndicator = "NOT_POPUP_WINDOW" ;

   try {
     if ( top.opener == popupWinIndicator ) return false ;
     else return true ;
   } catch ( Exception ) {
     return false ;
   }
 }


 function checkIllegalAccess() {

  try {
    top.HiddenFrame.location.href ;
    return false ;
  } catch ( Exception ) {
    return true ;
  }
 }

 function getAppropriateMode() {

   if (  checkIsPopUpWindow() ) {
         return "POPUP_SESSION_TIMEOUT" ;
   } else {
       if ( checkIllegalAccess() ) {
          return "ILLEGAL_ACCESS" ;
       } else {
         return "BODY_SESSION_TIMEOUT" ;
       }
   }
 }
////////////////////////////////////////////////////////


/**

 * @type   : function

 * @access : public

 * @desc   : 공통으로 사용하는 에러메세지 창을 띄운다.

 * @sig    : obj

 * @param  : obj required 에러가 난 가우스 오브젝트(DataSet or Transaction 오브젝트중 하나)

 * @author : GAUCE

 */

function cfShowError(obj) {

	var errObj = new Object();

	errObj.errCd = obj.ErrorCode;

	errObj.errMsg = obj.ErrorMsg;



	if (obj.ErrorMsg.indexOf("[BizException]") != -1) {

	   alert(obj.ErrorMsg.substr(obj.ErrorMsg.indexOf("[BizException]") + 14));

	} else if ( (obj.ErrorMsg.indexOf("[Exception]") != -1) ||

	            (obj.ErrorMsg.indexOf("[SysException]") != -1)

	          ) {
            alert("STEP-2");
		window.showModalDialog(GLB_URL_COMMON_PAGE + "error.html", errObj, "dialogWidth:790px; dialogHeight:590px; help:no; status:no; scroll:no")

	} else if (obj.ErrorMsg.indexOf("[AuthenticationFailed]") != -1) {

                var mode = getAppropriateMode() ;
                if ( checkIsPopUpWindow() ) {


                   cfOpen(560 , 380 ,5, getServerDNS() + "/login_sso.jsp?MODE="+mode, "login_sso","width=560, height=380");
                   top.close();
                } else {
                   location.href = getServerDNS() + "/login_sso.jsp?MODE="+mode ; // ?TARGET=$SM$" + location.href;
                }

  	} else {
    alert("STEP-3");
		window.showModalDialog(GLB_URL_COMMON_PAGE + "error.html", errObj, "dialogWidth:790px; dialogHeight:590px; help:no; status:no; scroll:no")

	}

}



/**

 * @type   : function

 * @access : public

 * @desc   : 가우스 Grid Object에 바인딩 되어 있는 Dataset의 데이터를 정렬(내림/오름차순)하고,

 * 			 Grid object의 컬럼명에 정렬방식에 따른 이미지를 보여준다. ▲(오름차순),▼(내림차순)

 * <pre>

 *    cfSortGrid(oGrid, SortFd);

 *

 * 사용예)

 *

 * 데이터셋의 onloadcompleted event가 발생했을때 그리드의 name에 sort칼럼 표시와

 * 데이터 셋의 정렬 칼럼에 의하여 오름/내림차순으로 데이터가 정렬된다.

 * 만약 가우스 Grid Object의 onclick event를 이용해서 정렬하는 경우는 onclick event가 발생 되었을때 함수를 호출하면된다.

 *

 * 1. Grid Object 선언

 *

 * &lt;object id="oSortGG" classid="CLSID:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49"

 * 	 width="0" height="405" style="position:absolute; left:10; top:89"&gt;

 *   &lt;param name="DataID"    value="oSortGDS"&gt;

 *   &lt;param name="Format"    value='

 *  	&lt;c&gt; id="sortcolumn", name="소트"&lt;/c&gt; '&gt;

 *

 * 2. 데이터셋의 onloadcompletd event가 발생했을때 함수를 호출한다.

 *

 * oSortGG: grid Object id, + : 오름차순, sortcolumn : 정렬하고자 하는 데이터 셋의 칼럼

 * &lt;script language="javascript" for="oSortGDS" event="OnLoadCompleted()"&gt;

 * 	cfSortGrid(oSortGG, "+sortcolumn");

 * &lt;/script&gt;

 *

 * 3. 함수 호출이 끝나면 다음과 같이 처리 된다.

 *

 * "&lt;c&gt; id="sortcolumn", name="소트"&lt;/c&gt;"  ==> "&lt;c&gt; id="sortcolumn", name="▲소트"&lt;/c&gt;"

 * </pre>

 * @sig    : oGrid, SortFd

 * @param  : oGrid required 정렬 표시할 Grid object

 * @param  : SortFd required 정렬방식 +(오름차순),-(내림차순)와 정렬하려고 하는 데이터셋의 칼럼아이디를 같이 표현한다.

 *           +colid ==> colid에 해당하는 데이터를 오름 차순으로 정렬한다.

 * @author : 조부구

 */

function cfSortGrid(oGrid, SortFd){

	if (oGrid.tagName == "OBJECT" &&

	    oGrid.attributes.classid.nodeValue.toUpperCase() == "CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" // DataSet

	   ) {

		oGrid.SortExpr.substring(0,1) == "+" ?

			oGrid.SortExpr = "-" + SortFd:

			oGrid.SortExpr = "+" + SortFd;

		oGrid.Sort();



		return;

	}



	var oDataSet = document.all(oGrid.DataId);



	SortGb	  = SortFd.substring(0,1);

	ColId     = SortFd.substring(1,SortFd.length);

	Now_name  = oGrid.ColumnProp(ColId,"name");



	if (oDataSet.SortExpr != '' ){

		old_colid     = oDataSet.SortExpr.substring(1,oDataSet.SortExpr.length);

		old_sortgubn  = oDataSet.SortExpr.substring(0,1);

		old_name  = oGrid.ColumnProp(old_colid,"name").substring(0,1);



		if ( old_name == '▲' || old_name == '▼' ){

			if ( old_colid != ColId ) {

				ReName = oGrid.ColumnProp(old_colid,"name").substring(1,oGrid.ColumnProp(old_colid,"name").length);

				oGrid.ColumnProp(old_colid,"name") = ReName;

			}

			else {

				ReName = oGrid.ColumnProp(ColId,"name").substring(1,oGrid.ColumnProp(ColId,"name").length);

				oGrid.ColumnProp(old_colid,"name") = ReName;

				Now_name = ReName;

				if ( old_sortgubn == '+' ){

					SortGb = '-';

				}

				else {

					SortGb = '+';

				}

			}

		}

	}



	oDataSet.SortExpr = SortGb + ColId;

	oDataSet.Sort();



	SortGb = oDataSet.SortExpr.substring(0,1);

	var SortType = '';

	if (SortGb == '+' ){

		SortType = '▲';

	}

	else {

		SortType = '▼';

	}

	oGrid.ColumnProp(ColId,"name") = SortType + Now_name;

}



/**
 * @type   : function
 * @access : public
 * @desc   : 가우스 Grid의 Style을 정해진 Style로 바꾸어준다. Style과 관련된 내용은 디자인표준문서를 참고할 것.
 * <pre>
 *     cfStyleGrid(oDelivRsltGG, "comn", features);
 * </pre>
 * @sig    : oGrid, styleName[, features]
 * @param  : oGrid     required Grid 오브젝트
 * @param  : styleName required Grid의 style name. 현재는 "comn" 과 "comnOnTab" 만 있다.
 * @param  : features  optional 기타 속성을 정의하는 스트링. 속성종류는 아래와 같다.
 * <pre>
 *     indWidth  : Grid의 IndWidth 속성 지정.
 *     rowHeight : Grid의 RowHeight 속성 지정.
 *     rowHeight : Grid의 titleHeight 속성 지정.
 *
 *     사용예) "indWidth=12,rowHeight=25,titleHeight=30"
 * </pre>
 * @author : GAUCE
 */

function cfStyleGrid(oGrid, styleName, features) {
	var titleHeight;
	var bgColor;
	var fontSize;
	var fontFamily;
	var LineColor;
	var sumColor;
	var sumBgColor;
	var subColor;
	var subBgColor;
	var subpressBgColor;
	var color;
	var headAlign;
	var headColor;
	var headBgColor;


	// <C> 컬럼 속성
	var CColor;
	var CHeadColor;
	var CHeadBgColor;


	// <FC> 컬럼 속성
	var FCColor;
	var FCBgColor;
	var FCHeadColor;
	var FCHeadBgColor;


	// <G> 컬럼 속성
	var GHeadColor;
	var GHeadBgColor;


	// <FG> 컬럼 속성
	var FGHeadColor;
	var FGHeadBgColor;


	// <X> 컬럼 속성
	var XHeadColor;
	var XHeadBgColor;


	// <FX> 컬럼 속성
	var FXHeadColor;
	var FXHeadBgColor;
	var featureNames  = ["indWidth","rowHeight","titleHeight"];
	var featureValues = [15, 20, 20];
	var featureTypes  = ["number", "number" ,"number"];

	if (features != null) {
		cfParseFeature(features, featureNames, featureValues, featureTypes);
	}

	var indWidth    = featureValues[0];
	var rowHeight   = featureValues[1];
	var titleHeight = featureValues[2];


	// Grid Style 별 정의
	switch (styleName) {
        case "comn":
        case "comn2":
			// Grid 속성
			titleHeight      = titleHeight;
			//titleHeight      = 20;
			fontSize         = "9pt";
			fontFamily       = "굴림";
			indWidth 		= "0";
			

			// 컬럼 공통 속성
			sumColor         = "#FFFFFF";
			sumBgColor       = "#5c7cac";
			subColor         = "#464646";
			subBgColor       = "#D8D8D8";
			//subpressBgColor  = "#FFFFFF";
			subpressBgColor  = "{decode(currow-tointeger(currow/2)*2,0,'#F5F7FA',1,'#FFFFFF')}"; //"#F0F0F0"


			// 컬럼별 속성
			CColor           = "#000000";
			CBgColor         = "{decode(currow-tointeger(currow/2)*2,0,'#F5F7FA',1,'#FFFFFF')}"; //"#FCFCFC"
			CHeadColor       = "#FFFFFF";
			//CHeadBgColor     = "#003F7D";
			//CHeadBgColor     = "#006699";
			CHeadBgColor     = "#5c7cac";

			FCColor          = "#000000";
			FCBgColor        = "{decode(currow-tointeger(currow/2)*2,0,'#F5F7FA',1,'#FFFFFF')}"; //"#F0F0F0"
			FCHeadColor      = "#FFFFFF";
			FCHeadBgColor    = "#888888";//5c7cac

			GHeadColor       = "#FFFFFF";
			GHeadBgColor     = "#5c7cac";

			FGHeadColor      = "#FFFFFB";
			FGHeadBgColor    = "#5c7cac";

			XHeadColor       = "#FFFFFB";
			XHeadBgColor     = "#5c7cac";

			FXHeadColor      = "#FFFFFB";
			FXHeadBgColor    = "#5c7cac";

			break;

		case "viewField":
			// Grid 속성
			titleHeight     = titleHeight;
			//titleHeight   = 20;
			fontSize        = "8pt";
			fontFamily      = "굴림";
			indWidth 		= "0";

			// 컬럼 공통 속성
			sumColor         = "#FFFFFF";
			sumBgColor       = "#5c7cac";
			subColor         = "464646";
			subBgColor       = "#D8D8D8";
			//subpressBgColor  = "#FFFFFF";
			subpressBgColor  = "{decode(currow-tointeger(currow/2)*2,0,'#F5F7FA',1,'#FFFFFF')}"; //"#F0F0F0"

			// 컬럼별 속성
			CColor           = "#000000";
			CBgColor         = "{decode(currow-tointeger(currow/2)*2,0,'#F5F7FA',1,'#FFFFFF')}"; //"#FCFCFC"
			CHeadColor       = "#FFFFFF";
			CHeadBgColor     = "#5c7cac";
			//CHeadBgColor     = "#006699";
			FCColor          = "#000000";
			FCBgColor        = "{decode(currow-tointeger(currow/2)*2,0,'#F5F7FA',1,'#FFFFFF')}"; //"#F0F0F0"
			FCHeadColor      = "#FFFFFF";
			FCHeadBgColor    = "#5c7cac"
			GHeadColor       = "#FFFFFF";
			GHeadBgColor     = "#5c7cac";
			FGHeadColor      = "#FFFFFF";
			FGHeadBgColor    = "#5c7cac";
			XHeadColor       = "#FFFFFF";
			XHeadBgColor     = "#5c7cac";
			FXHeadColor      = "#FFFFFF";
			FXHeadBgColor    = "#5c7cac";

			break;

        case "comn1":
            // Grid 속성
            titleHeight      = 40;
            fontSize         = "9pt";
            fontFamily       = "굴림";
            indWidth        = "0";
            
            // 컬럼 공통 속성
            sumColor         = "#FFFFFF";
            sumBgColor       = "#5c7cac";
            subColor         = "#464646";
            subBgColor       = "#D8D8D8";
            //subpressBgColor  = "#FFFFFF";
            subpressBgColor  = "{decode(currow-tointeger(currow/2)*2,0,'#F5F7FA',1,'#FFFFFF')}"; //"#F0F0F0"


            // 컬럼별 속성
            CColor           = "#000000";
            CBgColor         = "{decode(currow-tointeger(currow/2)*2,0,'#F5F7FA',1,'#FFFFFF')}"; //"#FCFCFC"
            CHeadColor       = "#FFFFFF";
            
            //CHeadBgColor     = "#003F7D";
            //CHeadBgColor     = "#006699";
            CHeadBgColor     = "#5c7cac";

            FCColor          = "#000000";
            FCBgColor        = "{decode(currow-tointeger(currow/2)*2,0,'#F5F7FA',1,'#FFFFFF')}"; //"#F0F0F0"
            FCHeadColor      = "#FFFFFF";
            FCHeadBgColor    = "#5c7cac"
            GHeadColor       = "#FFFFFF";
            GHeadBgColor     = "#5c7cac";
            FGHeadColor      = "#FFFFFB";
            FGHeadBgColor    = "#5c7cac";
            XHeadColor       = "#FFFFFB";
            XHeadBgColor     = "#5c7cac";
            FXHeadColor      = "#FFFFFB";
            FXHeadBgColor    = "#5c7cac";
            break;

		case "comnOnTab":
			// Grid 속성
			titleHeight      = 20;
			fontSize         = "9pt";
			fontFamily       = "굴림";

			// 컬럼 공통 속성
			sumColor     = "#FFFFFF";
			sumBgColor   = "#DCDDEF";
			subColor     = "464646";
			subBgColor   = "#D8D8D8";
			//subpressBgColor  = "#FFFFFF";
			subpressBgColor  = "{decode(currow-tointeger(currow/2)*2,0,'#F5F7FA',1,'#FFFFFB')}"; //"#F0F0F0"

			// 컬럼별 속성
			CColor           = "#454648";
			CBgColor         = "{decode(currow-tointeger(currow/2)*2,0,'#F5F7FA',1,'#FFFFFB')}"; //"#FCFCFC"
			CHeadColor       = "#1E3460";
			CHeadBgColor     = "#E3F4FA";
			FCColor          = "#454648";
			FCBgColor        = "{decode(currow-tointeger(currow/2)*2,0,'#F5F7FA',1,'#FFFFFB')}"; //"#F0F0F0"
			FCHeadColor      = "#1E3460";
			FCHeadBgColor    = "#C6D1E3"
			GHeadColor       = "#1E3460";
			GHeadBgColor     = "#ACBDD7";
			FGHeadColor      = "#1E3460";
			FGHeadBgColor    = "#E3F4FA";
			XHeadColor       = "#1E3460";
			XHeadBgColor     = "#E3F4FA";
			FXHeadColor      = "#1E3460";
			FXHeadBgColor    = "#E3F4FA";
			break;

		case "insa":
			// Grid 속성
			titleHeight      = titleHeight;
			fontSize         = "9pt";
			fontFamily       = "굴림";

			// 컬럼 공통 속성
			sumColor     = "#FFFFFF";
			sumBgColor   = "#DCDDEF";
			subColor     = "464646";
			subBgColor   = "#D8D8D8";
			//subpressBgColor  = "#FFFFFF";
			subpressBgColor  = "{decode(currow-tointeger(currow/2)*2,0,'#F5F7FA',1,'#FFFFFB')}"; //"#F0F0F0"

			// 컬럼별 속성
			CColor           = "#454648";
			CBgColor         = "{decode(currow-tointeger(currow/2)*2,0,'#F5F7FA',1,'#FFFFFF')}"; //"#FCFCFC"
			CHeadColor       = "#0D162B";
			CHeadBgColor     = "#D2DEF4";
			FCColor          = "#454648";
			FCBgColor        = "{decode(currow-tointeger(currow/2)*2,0,'#F5F7FA',1,'#FFFFFF')}"; //"#F0F0F0"
			FCHeadColor      = "#1E3460";
			FCHeadBgColor    = "#C6D1E3"
			GHeadColor       = "#1E3460";
			GHeadBgColor     = "#D2DEF4";
			FGHeadColor      = "#1E3460";
			FGHeadBgColor    = "#E3F4FA";
			XHeadColor       = "#1E3460";
			XHeadBgColor     = "#E3F4FA";
			FXHeadColor      = "#1E3460";
			FXHeadBgColor    = "#E3F4FA";
			break;

		default:
			return;
	}


	// Grid 속성 설정
	{
		oGrid.RowHeight = rowHeight;
		oGrid.TitleHeight = titleHeight;
		oGrid.IndWidth = indWidth;
		oGrid.style.fontSize    = fontSize;
		oGrid.style.fontFamily  = fontFamily;
	}

	var tagRE = /<(fc|c|g|fg|x|fx)>/i;
	var colAttrRE = /([\w_]+)\s*=\s*['"]?([^<'"\s,]+)/i;

	var gFormat = oGrid.Format;
	var newGFormat = "";
	var tagMatch;
	var tagName;
	var colAttrData;
	var colAttrMatch;
	var colAttrName;
	var colAttrValue;
	var insertStr;

	// Grid Format String 을 파싱하여 컬럼별로 Style 과 관련된 속성을 삽입한다.
	while ((tagMatch = gFormat.match(tagRE)) != null) {
		var style = "";
		var isSupress = false;

		// 사용자가 지정한 컬럼 속성에 따른 처리
		colAttrData = gFormat.substring(tagMatch.lastIndex, gFormat.indexOf("<", tagMatch.lastIndex));

		while ( (colAttrMatch = colAttrData.match(colAttrRE)) != null) {
			colAttrName = colAttrMatch[1].toUpperCase();
			colAttrValue = colAttrMatch[2].toUpperCase();

			if (colAttrName == "STYLE") {
				if (colAttrValue == "TITLE") {
					style = "TITLE";
				} else if (colAttrValue == "REQUIRED") {
					style = "REQUIRED";
				}
			}

			if (colAttrName == "SUPPRESS") {
				isSupress = true;
			}

			colAttrData = colAttrData.substr(colAttrMatch.lastIndex);
		}

		insertStr = "";
		tagName = tagMatch[1].trim().toUpperCase();

		switch (tagName) {
			case "C" :
				headAlign = "Center";
				headColor = CHeadColor;
				headBgColor= CHeadBgColor;

				if (isSupress) {
					insertStr = insertStr + " BgColor=" + subpressBgColor;
				} else {
					insertStr = insertStr + " BgColor=" + CBgColor;
				}

				insertStr = insertStr + " Color=" + CColor +
				            " SumColor=" + sumColor +
				            " SumBgColor=" + sumBgColor +
				            " SubColor=" + subColor +
				            " SubBgColor=" + subBgColor;
				break;

			case "FC" :
				headAlign = "Center";
				headColor= FCHeadColor;
				headBgColor= FCHeadBgColor;

				if (isSupress) {
					insertStr = insertStr + " BgColor=" + subpressBgColor;
				} else {
					insertStr = insertStr + " BgColor=" + FCBgColor;
				}

				insertStr = insertStr + " Color=" + FCColor +
				            " SumColor=" + sumColor +
				            " SumBgColor=" + sumBgColor +
				            " SubColor=" + subColor +
				            " SubBgColor=" + subBgColor;
				break;

			case "G" :
				headAlign = "Center";
				headColor= GHeadColor;
				headBgColor= GHeadBgColor;
				break;

			case "FG" :
				headAlign = "Center";
				headColor= FGHeadColor;
				headBgColor= FGHeadBgColor;
				break;

			case "X" :
				headAlign = "Center";
				headColor= XHeadColor;
				headBgColor= XHeadBgColor;
				break;

			case "FX" :
				headAlign = "Center";
				headColor= FXHeadColor;
				headBgColor= FXHeadBgColor;
				break;

			default :
				break;
		}

		// 사용자가 지정한 컬럼 속성에 따른 처리
		colAttrData = gFormat.substring(tagMatch.lastIndex, gFormat.indexOf("<", tagMatch.lastIndex));

		if (style == "TITLE") {
			headColor = "#FFFFFF";
			headBgColor = "#8AA1C2";
			headAlign = "Left";
		} else if (style == "REQUIRED") {
			headColor = "#1467E4";
		}

		// Grid의 Format 에 Style 관련 속성값들을 삽입한다.
		insertStr = insertStr +
			        " HeadColor=" + headColor +
			        " HeadBgColor=" + headBgColor +
			        " HeadAlign=" + headAlign + " ";

		newGFormat = newGFormat + gFormat.substring(0, tagMatch.lastIndex) + insertStr;
		gFormat = gFormat.substr(tagMatch.lastIndex);
	}

	newGFormat = newGFormat + gFormat;
	oGrid.Format = newGFormat;

    if(styleName=="comn2"){
		oGrid.SelectionColorProp("FocusEditRow", "BgColor") = "#D1DEF0";
	//    oGrid.SelectionColorProp("FocusEditCol", "BgColor") = "#D1DEF0";
	    oGrid.SelectionColorProp("FocusEditCol", "BgColor") = "#FFFFFF";
		oGrid.SelectionColorProp("FocusEditCol", "TextColor") = "Black";
		oGrid.SelectionColorProp("FocusSelRow", "BgColor") = "#D1DEF0";
		oGrid.SelectionColorProp("FocusSelRow", "TextColor") = "Black";
		oGrid.SelectionColorProp("FocusCurRow", "BgColor") = "#D1DEF0";
		oGrid.SelectionColorProp("FocusCurRow", "TextColor") = "Black";
		oGrid.SelectionColorProp("SelRow", "BgColor") = "#D1DEF0";
		oGrid.SelectionColorProp("CurRow", "BgColor") = "#D1DEF0";
	    oGrid.SelectionColorProp("CurCol", "BgColor") = "#D1DEF0";
	//    oGrid.SelectionColorProp("CurCol", "BgColor") = "#FFFFFF";
		oGrid.SelectionColorProp("CurCol", "TextColor") = "Black";
		oGrid.LineColor = "#A0B1CA";
	} else {
        oGrid.SelectionColorProp("FocusEditRow", "BgColor") = "#D1DEF0";
        oGrid.SelectionColorProp("FocusEditCol", "BgColor") = "#D1DEF0";
        oGrid.SelectionColorProp("FocusEditCol", "TextColor") = "Black";
        oGrid.SelectionColorProp("FocusSelRow", "BgColor") = "#D1DEF0";
        oGrid.SelectionColorProp("FocusSelRow", "TextColor") = "Black";
        oGrid.SelectionColorProp("FocusCurRow", "BgColor") = "#D1DEF0";
        oGrid.SelectionColorProp("FocusCurRow", "TextColor") = "Black";
        
        oGrid.SelectionColorProp("SelRow", "BgColor") = "#D1DEF0";
        oGrid.SelectionColorProp("CurRow", "BgColor") = "#D1DEF0";
        oGrid.SelectionColorProp("CurCol", "BgColor") = "#FFFFFF";
        oGrid.SelectionColorProp("CurCol", "TextColor") = "Black";
    
        oGrid.LineColor = "#A0B1CA";
    }
	oGrid.RowPosition = 0;

}




/**

 * @type   : function

 * @access : public

 * @desc   : 가우스 Tab의 Style을 정해진 Style로 바꾸어준다.

 * <pre>

 *     cfStyleTab(oDomRegiRecevGTab, "comn");

 * </pre>

 * @sig    : oTab, styleName

 * @param  : oTab required Tab 오브젝트
 * @param  : styleName required Tab의 style name. 현재는 "comn" 과 "comnOnTab" 만 있다.

 * @author : GAUCE

 */

function cfStyleTab(oTab, styleName) {

	var backColor;

	var textColor;

	var disableBackColor;

	var disableTextColor;



	switch (styleName) {

		case "comn" :

			backColor = "#E6E2D8";

			textColor = "#1E56C3";

			disableBackColor = "#CFCFCD";

			disableTextColor = "#222866";

			break;



		case "comnOnTab" :

			backColor = "#E6E2D8";

			textColor = "#1E56C3";

			disableBackColor = "#CFCFCD";

			disableTextColor = "#222866";

			break;



		default :

			break;

	}



	oTab.style.fontSize = "9pt";



	oTab.BackColor = backColor;

	oTab.TextColor = textColor;

	//oTab.DisableBackColor = disableBackColor;

	oTab.DisableTextColor = disableTextColor;

}



/**

 * @type   : function

 * @access : public

 * @desc   : 가우스 Tree의 Style을 정해진 Style로 바꾸어준다.

 * <pre>

 *     cfStyleTreeView(oDomRegiGTree, "comn");

 * </pre>

 * @sig    : oTree, styleName

 * @param  : oTree     required Tree 오브젝트
 * @param  : styleName required Tree의 style name. 현재는 "comn" 과 "comnOnTab" 만 있다.

 * @author : GAUCE

 */

function cfStyleTreeView(oTreeView, styleName) {

/*

	var iDataSet;

	var dateString;



	if (document.all("coTreeViewImageComnGIDS") == null) {

		iDataSet          = document.createElement("<OBJECT>");

		iDataSet.classid  = "CLSID:BCB3A52D-F8E7-11D3-973E-0060979E2A03";

		iDataSet.id       = "coTreeViewImageComnGIDS";

		iDataSet.SyncLoad = "true";

		iDataSet.DataId   = "/common/csv/treeview_imagedata.csv";



		// </head> 태그 직전에 ImageDataSet 삽입

		for (var i = 0; i < document.all.length; i++) {

			if (document.all[i].tagName == "HEAD") {

				document.all[i].insertAdjacentElement("beforeEnd", iDataSet);

				break;

			}

		}

	} else {

		iDataSet = document.all("coTreeViewImageComnGIDS");

	}



	iDataSet.Reset();



	oTreeView.ImgDataID  = "coTreeViewImageComnGIDS";



	// TreeView에서 자식노드를 가지고 있고, 확장되지 않은 Item에서 사용할 이미지칼럼명을 지정한다.

	oTreeView.ImgCColumn = "ImgC";



	// TreeView에서 자식노드를 가지고 있지 않은 Item에 사용될 이미지칼럼명을 지정한다.

	oTreeView.ImgDColumn = "ImgD";



	// TreeView에서 자식노드를 가지고 있고, 확장된 Item에서 사용할 이미지칼럼명을 지정한다.

	oTreeView.ImgOColumn = "ImgO";

*/

	switch (styleName) {

		case "comn" :

			oTreeView.style.fontSize = "9pt";

			break;



		case "comnOnTab" :

			oTreeView.style.fontSize = "9pt";

			break;



		default :

			break;

	}

}



/**

 * @type   : function

 * @access : public

 * @desc   : 화면상의 입력과 관련된 오브젝트에 대한 유효성 검사를 실시한다. 유효성 검사를 받는 오브젝트들은 "validExp" 라는

 *           속성값을 설정해야 한다. "validExp" 라는 속성은 원래 html 객체에는 정의되어 있지 않은 속성이지만 다른 속성들을

 *           설정하는 것과 같은 방법으로 설정하면 자동으로 해당 오브젝트의 속성으로 인식된다.<br><br>

 *           - 해당 오브젝트에 대한 child 오브젝트들까지도 검사한다. 예를들어, 검사받을 오브젝트들을 &lt;div&gt; 태그로 감싸고

 *             &lt;div&gt; 태그의 id를 파라미터로 준다면 &lt;div&gt; 태그내의 모든 오브젝트들이 자동으로 검사받게 된다. 또,

 *             &lt;table&gt;안에 입력필드들은 &lt;table&gt;의 id를 파라미터로 주면 된다.<br><br>

 *           - 입력값의 앞과 뒤의 공백은 유효성 검사를 하면서 자동으로 trim된다.

 * <pre>

 *    예1)

 *    ...

 *    function fncSave() {

 *        if (<b>cfValidate([oRecevInfo])</b>) {

 *            oDomRegiRecevGTR.post();

 *        }

 *    }

 *    ...

 *

 *    &lt;table <b>id="oRecevInfo"</b> ....&gt;

 *        ...

 *        &lt;object id="oRecevNo" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F" width="50" <b>validExp="접수번호:yes:length=6"</b>&gt;

 *            &lt;param name="Format"    value="000000"&gt;

 *        &lt;/object&gt;

 *        ...

 *    &lt;/table&gt;

 *    ...

 * </pre>

 * validExp 속성값은 정해진 형식에 맞게 작성되어야 하는데 형식은 오브젝트의 종류에 따라 두 가지로 나뉜다.<br>

 * <pre>

 *    1. 일반 오브젝트의 경우 (예1 참조)

 *        "item_name:필수여부:valid_expression"

 *

 *        - "item_name"에는 해당 항목에 대한 이름을 기술한다.

 *        - "필수여부"에는 해당 오브젝트가 필수 항목인지 여부를 yes|true|1 혹은 no|false|0 타입으로 기술한다.

 *        - "valid_expression" 은  cfValidateValue 함수의 설명을 참조하기 바란다.

 *        - 필수항목인지만 체크하려면 "valid_expression" 을 표기하지 않으면 된다.

 *          예)

 *          &lt;object id="oDelivYmd" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F" width="80" <b>validExp="배달일자:yes"</b>&gt;

 *              ...

 *			&lt;/object&gt;

 *        - validExp 내에 임의로 ",", ":", "=", "&", 문자를 사용하고자 한다면 "\\,", "\\:", "\\=", "\\&" 라고 표기해야 한다.<br>

 *

 *

 *    2. 가우스 Grid 오브젝트의 경우

 *        "column_id:item_name:필수여부[:valid_expression[:key]][,column_name:item_name:필수여부[:valid_expression[:key]]]..."

 *

 *        - column_id 에는  Grid와 연결된 DataSet의 실제 컬럼 id 를 적어준다.

 *

 *        - <font color=blue><b>dataName</b></font> 이라는 속성도 기술해 주어야 한다. dataName은 해당 DataSet

 *          을 표현하는 이름을 기술해 주면 된다.

 *

 *        - <font color=blue><b>validFeatures</b></font> 라는 속성은 필요에 따라 기술해 주어야 한다. validFeatures은 Grid Validation

 *          수행시에 필요한 수행조건을 기술해 주는 속성으로써 기술해 주지 않으면 기본 수행조건이 자동으로 적용된다.

 *          표현하는 형식은 <b>validFeatures="수행조건명1=수행조건값1,수행조건명2=수행조건값2, ... 수행조건명n=수행조건값n"</b> 이다.

 *          현재 사용가능한 수행조건은 다음과 같다.

 *

 *          ignoreStatus : 변경사항이 없는 Row 에 대해서도 validation을 수행할지 여부. (yes|true|1 or no|false|0)

 *

 *        예)

 *

 *        cfValidate([oDomRegiRecevGG]);

 *        ...

 *        &ltobject id="oDomRegiRecevGG" classid="CLSID:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49"

 *           width="174" height="233" style="position:absolute; left:10; top:73;" <b>dataName="배달결과리스트"</b> <b>validFeatures="ignoreStatus=yes"</b>

 *         <b>validExp="regiNo:등기번호:yes:length=13:key,

 *                  sendPrsnZipNo:발송인우편번호:yes:length=6,

 *                  recPrsnZipNo:수취인우편번호:yes:length=6

 *                 "</b>

 *        &gt;

 *

 *        - 만약 item_name을 기술하지 않았을 경우에는 Grid의 column_id에 해당하는 컬럼의 컬럼명으로 자동으로 대체된다.

 *          예) validExp="regiNo::yes:length=13, ..."

 *

 *        - 만약 컬럼이 key컬럼일 경우에는 끝에 "key" 라고 명시해 준다. "key" 라고 명시해 주면 다른 Row와 데이터가 중복되었을 때

 *          에러를 발생시킨다. key컬럼이 여럿일 경우에는 key컬럼들을 묶어서 하나의 key로 인식하기 때문에 key컬럼중에 하나만

 *          중복이 되지 않아도 전체가 중복되지 않은 것으로 처리된다. key컬럼들을 ?횡底? 처리하지 않고 key컬럼별로 개별적인

 *          중복체크를 원할 경우에는 "singleKey" 라고 명시하면 된다.

 *          단, key를 명시해 줄 경우에는 valid_expression 을 반드시 기입해 주고 기입해 줄 내용이 없더라도

 *          ':' 을 삽입해야 한다.

 *          예) validExp="regiNo:등기번호:yes::key, ...

 *

 *        - 나머지는 1의 경우와 같다.

 * </pre>

 * @sig    : objArr

 * @param  : objectArr required 유효성검사를 하고자 하는 오브젝트들의 Array.

 * @return : boolean. 유효성 여부.

 * @author : GAUCE

 */

function cfValidate(obj) {

	if (cfIsNull(obj)) {

		return;

	}



	var objArr;

	var oElement;

	var validYN = false;



	if (obj.length == null) {

		objArr = new Array(1);

		objArr[0] = obj;

	} else {

		objArr = obj;

	}



	for (var objArrIdx = 0; objArrIdx < objArr.length; objArrIdx++) {

		oElement = objArr[objArrIdx];



		switch (oElement.tagName) {

			case "TABLE":

			case "DIV":

			case "FIELDSET":

				for (var i = 0; i < oElement.all.length; i++) {

					if (!cfValidateElement(oElement.all[i])) {

						return false;

					}

				}



				break;



			default:

				if (!cfValidateElement(oElement)) {

					return false;

				}

		}

	}



	return true;

}



/**

 * @type   : function

 * @access : private

 * @desc   : 가우스와 html 의 모든 오브젝트에 대해 유효성 검사를 한다.

 * @sig    : oElement

 * @param  : oElement required 검사 대상 Element.

 * @return : boolean. 유효성 여부.

 * @author : GAUCE

 */

function cfValidateElement(oElement) {

	if (oElement.tagName == "OBJECT" &&

	    oElement.attributes.classid.nodeValue.toUpperCase() == "CLSID:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49"

	   ) {

		return cfValidateGrid(oElement);

	} else {

		return cfValidateItem(oElement);

	}

}





/**

 * @type   : function

 * @access : private

 * @desc   : 가우스 컴포넌트 중에서 DataSet을 제외한 모든 오브젝트와 html의 모든 오브젝트에 대해 유효성 검사를 한다.

 * @sig    : oElement

 * @param  : oElement required 검사 대상 Element.

 * @return : boolean. 유효성 여부.

 * @author : GAUCE

 */

function cfValidateItem(oElement) {

	if (cfIsNull(oElement.validExp)) {

		return true;

	}



	var value;

	var itemValidExp = new covItemValidExp(oElement.validExp);



	switch (oElement.tagName) {

		case "INPUT":



		case "SELECT":



		case "TEXTAREA":

			oElement.value = oElement.value.trim();  // element의 값을 trim 시켜준다.

			value = oElement.value;

			break;



		case "OBJECT":

			switch (oElement.attributes.classid.nodeValue.toUpperCase()) {

				case "CLSID:FD4C6571-DD20-11D2-973D-00104B15E56F": // CodeCombo Component

				case "CLSID:14DA1FE5-438E-4E2C-959D-5BF03F63EA9C": // CodeCombo2 Component

				case "CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0": // Radio Component

					oElement.CodeValue = (oElement.CodeValue == null) ? null : oElement.CodeValue.trim();  // element의 값을 trim 시켜준다.

					value = oElement.CodeValue;

                    break;



                case "CLSID:91B0A4F0-3206-4564-9BB4-AF9055DEF8A1": // TextArea Component

				case "CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03": // InputFile Component

				case "CLSID:E6876E99-7C28-43AD-9088-315DC302C05F": // EMedit Component

					oElement.Text = (oElement.Text == null) ? null : oElement.Text.trim();  // element의 값을 trim 시켜준다.

					value = oElement.Text;

                    break;



                default:

                	break;

			}



			break;



		default:

			return true;

	}



	if (!itemValidExp.validate(value)) {

		alert(new coMessage().getMsg(itemValidExp.errMsg, [itemValidExp.itemName]));



		if(oElement.enable != false && oElement.disabled!=true) {

			oElement.focus();

		}



		return false;

	}



	return true;

}



/**

 * @type   : function

 * @access : public

 * @desc   : 가우스의 Grid에 대해 유효성 검사를 한다. 유효성 검사를 위해서는 Grid의 DataId에 지정된 DataSet에 validExp 속성이

 *           지정되어 있어야 한다. 지정방법은 cfValidate 함수에 대한 설명을 참조하기 바란다. (내부적으로는 Grid를 검사하는 것이 아니라

 *           Grid의 DataId에 지정된 DataSet에 대한 유효성 검사이다.)

 * @sig    : oGrid[, row[, colId]]

 * @param  : oGrid required 검사 대상 Grid.

 * @param  : row   optional 검사하고자 하는 row 번호

 * @param  : colId optional 검사하고자 하는 컬럼의 id

 * @return : boolean. 유효성 여부.

 * @author : GAUCE

 */

function cfValidateGrid(oGrid, row, colId) {

	if (cfIsNull(oGrid.validExp)) {

		return true;

	}



	var dataName = oGrid.dataName;

	var validFeatures = oGrid.validFeatures;

	var oDataSet = document.all(oGrid.DataId);

	var gridValidExp = new covGridValidExp(oGrid);

	var errMsg = "";



	var featureNames  = ["ignoreStatus"];

	var featureValues = [false];

	var featureTypes  = ["boolean"];



	if (validFeatures != null) {

		cfParseFeature(validFeatures, featureNames, featureValues, featureTypes);

	}



	var ignoreStatus = featureValues[0];



	if (!gridValidExp.validate(row, colId, ignoreStatus)) {

		alert(new coMessage().getMsg("@의 @번째 데이터에서 ", [dataName, String(gridValidExp.errRow)]) +

		      new coMessage().getMsg(gridValidExp.errMsg, [gridValidExp.errItemName])

		     );

//		oDataSet.RowPosition = gridValidExp.errRow;  // 이순간 또다시 CanRowPosChange 이벤트가 발생하여 무한루프에 빠진다.

        if (oGrid.MultiRowSelect == false) {  // Grid의 MultiRowSelect 속성이 false일 경우에는 RowMark, MarkRows가

        	oGrid.MultiRowSelect = true;      // 지정한 row에 제대로 Marking을 하지 못한다. 따라서...

    		oDataSet.ClearAllMark();

    		oDataSet.RowMark(gridValidExp.errRow) = 1;

    		oGrid.SetColumn(gridValidExp.errColId);

    		oGrid.Focus();

            oGrid.MultiRowSelect = false;

        } else {

    		oDataSet.ClearAllMark();

    		oDataSet.RowMark(gridValidExp.errRow) = 1;

    		oGrid.SetColumn(gridValidExp.errColId);

    		oGrid.Focus();

        }



		return false;

	}



	return true;

}



/**

 * @type   : function

 * @access : public

 * @desc   : 사용자의 입력값이 Byte로 환산된 최대길이를 넘을 경우 입력이 안되도록 하는 함수. <br>

 *           안타깝게도 Windows XP 환경에서는 한글에 대한 키이벤트가 발생하지 않아서 동작하지 않는다.<br>

 *           오브젝트 선언시 onkeydown 이벤트에 다음과 같이 기술해 주어야만 한다.

 * <pre>

 *     onkeydown="cfValidateMaxByteLength(this, max_byte_length)"

 *     (여기서 max_byte_length 자리에는 Byte로 환산시 최대길이를 숫자로 적어준다.)

 *

 *     예)

 *     &lt;input type="text" size="10" onkeydown="cfValidateMaxByteLength(this, 10)"&gt;

 * </pre>

 *           현재는 html의 text input, textarea 와 가우스의 EMEdit 에만 적용된다.

 * @sig    : oElement, length

 * @param  : oElement required 입력필드 객체
 * @param  : length   required max byte length
 * @author : GAUCE

 */

function cfValidateMaxByteLength(oElement, length) {

	var value = "";



	if (event.keyCode == 8 ||   // backspace

	    event.keyCode == 35 ||  // end key

	    event.keyCode == 36 ||  // home key

	    event.keyCode == 37 ||  // left key

	    event.keyCode == 38 ||  // up key

	    event.keyCode == 39 ||  // right key

	    event.keyCode == 40 ||  // down key

	    event.keyCode == 46     // delete key

	   ) {

	   	return true;

	}



	switch (cfGetElementType(oElement)) {

		case "TEXT" :

		case "TEXTAREA" :

			value = oElement.value;

			break;



		case "GE" :

		case "GTA" :

			value = oElement.Text;

			break;



		default :

			return;

	}



	if (cfGetByteLength(value) > length ) {

  		oElement.blur();

		oElement.focus();

     	oElement.value = oElement.value.substr(0, oElement.value.length - 1);

		event.returnValue = false;

		return;

	}



	if (oElement.onkeyup == null) {

		oElement.onkeyup =

			function() {

				if (cfGetByteLength(oElement.value) > length) {

			    	oElement.blur();

			        oElement.focus();

			        oElement.value = oElement.value.substr(0, oElement.value.length - 1);

				}

			}

	}



	if (cfGetByteLength(value) == length ) {

       // 완성한글 : 0xAC00 <= c && c <= 0xD7A3

       // 자음 : 0x3131 <= c

       // 모음 : c <= 0x318E

		var c = value.charCodeAt(value.length - 1);



		if ( (0xAC00 <= c && c <= 0xD7A3) || (0x3131 <= c && c <= 0x318E) ) {

			event.returnValue = true;

    	} else {

			event.returnValue = false;

		}

	} else {

		event.returnValue = true;

	}

}



/**

 * @type   : function

 * @access : public

 * @desc   : 특정 값에 대한 유효성검사를 수행한다.

 * <pre>

 *     cfValidateValue(50, "minNumber=100");

 * </pre>

 * 위의 경우 50은 최소값 100을 넘지 않으므로 false가 리턴된다.<br>

 * 유효성 검사를 수행하기 위해서는 검사조건을 명시해야 하는데

 * 검사조건은 'valid expression' 이라고 불리우는 String 값으로 표현된다. valid expression에 대한 표기형식은

 * 다음과 같다.

 * <pre>

 *  	validator_name=valid_value[&validator_name=valid_value]..

 *

 *  	예) "minNumber=100"

 * </pre>

 * - validator_name은 검사유형을 의미하며 valid_value는 기준 값이 된다. <br>

 * - 검사항목은 하나 이상일 수 있으며 검사항목간에는 "&" 문자로 구분하여 필요한 만큼 나열하면 된다. <br>

 * - valid_value에 ",", ":", "=", "&", 문자를 사용하고자 한다면 "\\,", "\\:", "\\=", "\\&" 라고 표기해야 한다.<br>

 * - 위의 예에서는 "minNumber" (최소값)라는 유효성 검사항목을 명시하였고 minNumber 에대한 기준값으로 "100" 이 설정되어 있다.

 * 만일 100보다 작은 값을 입력했을 때는 100 이상의 값을 입력하라는 alert box가 뜨게 된다.

 * - validator_name은 미리 정의되어 있는 것만 사용할 수 있고 각 검사유형마다 valid_value의 형태도 다르다.(valid_value가 없는 것도 있다.)

 * 현재 정의된 검사유형은 다음과 같다.

 * <br><br>

 * <table border=1 style="border-collapse:collapse; border-width:1pt; border-style:solid; border-color:000000;">

 * 		<tr>

 * 			<td align="center" bgcolor="#CCCCFFF">검사유형</td>

 * 			<td align="center" bgcolor="#CCCCFFF">기준값 형태</td>

 * 			<td align="center" bgcolor="#CCCCFFF">설명</td>

 * 			<td align="center" bgcolor="#CCCCFFF">예</td>

 * 		</tr>

 * 		<tr>

 * 			<td>length</td>

 * 			<td>0보다 큰 정수</td>

 * 			<td>자릿수 검사. 입력값의 자릿수가 기준값과 일치하는지를 검사한다. 일반적으로 HTML에서는 한글, 영문, 숫자 모두 1자리씩 인식된다.</td>

 * 			<td>length=6</td>

 * 		</tr>

 * 		<tr>

 * 			<td>byteLength</td>

 * 			<td>0보다 큰 정수</td>

 * 			<td>Byte로 환산된 자릿수 검사. 입력값의 자릿수를 byte로 환산하여 자릿수가 기준값과 일치하는지를 검사한다.(숫자 및 영문은 1byte, 한글은 2byte이다.)</td>

 * 			<td>byteLength=6</td>

 * 		</tr>

 * 		<tr>

 * 			<td>minLength</td>

 * 			<td>0보다 큰 정수</td>

 * 			<td>최소자릿수 검사. 입력값의 자릿수가 기준값 이상이 되는지를 검사한다.</td>

 * 			<td>minLength=6</td>

 * 		</tr>

 * 		<tr>

 * 			<td>minByteLength</td>

 * 			<td>0보다 큰 정수</td>

 * 			<td>Byte로 환산된 최소자릿수 검사. 입력값의 자릿수를 byte로 환산하여 자릿수가 기준값 이상이 되는지를 검사한다.(숫자 및 영문은 1byte, 한글은 2byte이다.)</td>

 * 			<td>minByteLength=6</td>

 * 		</tr>

 * 		<tr>

 * 			<td>maxLength</td>

 * 			<td>0보다 큰 정수</td>

 * 			<td>최대자릿수 검사. 입력값의 자릿수가 기준값 이하가 되는지를 검사한다.</td>

 * 			<td>maxLength=6</td>

 * 		</tr>

 * 		<tr>

 * 			<td>maxByteLength</td>

 * 			<td>0보다 큰 정수</td>

 * 			<td>Byte로 환산된 최대자릿수 검사. 입력값의 자릿수를 byte로 환산하여 자릿수가 기준값 이하가 되는지를 검사한다.(숫자 및 영문은 1byte, 한글은 2byte이다.)</td>

 * 			<td>maxByteLength=6</td>

 * 		</tr>

 * 		<tr>

 * 			<td>number</td>

 * 			<td>None or decimal format string. decimal format string 형식은 "(정수자릿수.소수자릿수)" 이다.</td>

 * 			<td>숫자검사. 입력값이 숫자인지를 검사한다. 만일 입력값에 대한 decimal format을 지정하였을 때는 format에 맞는지도 검사한다.</td>

 * 			<td>number, number=(5.2)</td>

 * 		</tr>

 * 		<tr>

 * 			<td>minNumber</td>

 * 			<td>숫자</td>

 * 			<td>최소수 검사. 입력값이 최소한 기준값 이상이 되는지를 검사한다.</td>

 * 			<td>minNumber=100</td>

 * 		</tr>

 * 		<tr>

 * 			<td>maxNumber</td>

 * 			<td>숫자</td>

 * 			<td>최대수 검사. 입력값이 기준값 이하인지를 검사한다.</td>

 * 			<td>maxNumber=300</td>

 * 		</tr>

 * 		<tr>

 * 			<td>inNumber</td>

 * 			<td>"숫자~숫자" 형식으로 표기.</td>

 * 			<td>범위값 검사. 입력값이 기준이 되는 두 수와 같거나 혹은 두 수 사이에 존재하는 값인지를 검사한다.</td>

 * 			<td>inNumber=100~300</td>

 * 		</tr>

 * 		<tr>

 * 			<td>minDate</td>

 * 			<td>YYYYMMDD 형식의 날짜 스트링.</td>

 * 			<td>최소날짜 검사. 입력된 날짜가 기준날짜이거나 기준날짜 이후인지를 검사한다.</td>

 * 			<td>minDate=20020305</td>

 * 		</tr>

 * 		<tr>

 * 			<td>maxDate</td>

 * 			<td>YYYYMMDD 형식의 날짜 스트링. 예) maxDate=20020305</td>

 * 			<td>최대날짜 검사. 입력된 날짜가 기준날짜이거나 기준날짜 이전인지를 검사한다.</td>

 * 			<td>maxDate=20020305</td>

 * 		</tr>

 * 		<tr>

 * 			<td>format</td>

 * 			<td>format character들과 다른 문자들을 조합한 스트링.<br>

 * 				<table>

 * 					<tr>

 * 						<td><b>format character</b></td>

 * 						<td><b>desc</b></td>

 * 					</tr>

 * 					<tr>

 * 						<td>#</td>

 * 						<td>문자와 숫자</td>

 * 					</tr>

 * 					<tr>

 * 						<td>h, H</td>

 * 						<td>한글(H는 공백포함)</td>

 * 					</tr>

 * 					<tr>

 * 						<td>A, Z</td>

 * 						<td>문자(Z는 공백포함)</td>

 * 					</tr>

 * 					<tr>

 * 						<td>0, 9</td>

 * 						<td>숫자 (9는 공백포함)</td>

 * 					</tr>

 * 				</table>

 * 			</td>

 * 			<td>형식 검사. 입력된 값이 지정된 형식에 맞는지를 검사한다.</td>

 * 			<td>format=000-000</td>

 * 		</tr>

 * 		<tr>

 * 			<td>ssn</td>

 * 			<td>주민등록번호 13자리</td>

 * 			<td>주민등록번호 검사. 입력한 주민등록번호가 유효한지를 검사한다.</td>

 * 			<td>ssn</td>

 * 		</tr>

 * 		<tr>

 * 			<td>csn</td>

 * 			<td>사업자등록번호 10자리</td>

 * 			<td>사업자등록번호 검사. 입력한 사업자등록번호가 유효한지를 검사한다.

 *              (예, 2019009930)

 *          </td>

 * 			<td>csn</td>

 * 		</tr>

 * 		<tr>

 * 			<td>filterIn</td>

 * 			<td>필터링하여 얻고자 하는 스트링을 ";"문자를 구분자로 사용하여 나열한다.(단 ";" 문자를 필터링하고 싶을 땐 "\;"라고 표기한다.

 *          </td>

 * 			<td>입력값에 지정된 문자나 스트링 이외에 다른 값이 있는지를 검사한다. 하나도 없다면 유효하다.</td>

 * 			<td>filter=%;<;GAUCE;\\;;haha<br>(입력값 내에 "%","<","GAUCE",";","haha" 중에 하나라도 있는지 검사한다.)

 *          </td>

 * 		</tr>

 * 		<tr>

 * 			<td>filterOut</td>

 * 			<td>필터링하여 걸러내고 싶은 스트링을 ";"문자를 구분자로 사용하여 나열한다.(단 ";" 문자를 필터링하고 싶을 땐 "\;"라고 표기한다.

 *          </td>

 * 			<td>입력값에 지정된 문자나 스트링이 있는지를 검사한다. 하나도 없다면 유효하다.</td>

 * 			<td>filter=%;<;GAUCE;\\;;haha<br>(입력값 내에 "%","<","GAUCE",";","haha" 중에 하나라도 있는지 검사한다.)

 *          </td>

 * 		</tr>

 * 		<tr>

 * 			<td>email</td>

 * 			<td>이메일 주소</td>

 * 			<td>입력한 메일주소가 유효한 이메일 형식인지를 검사한다.</td>

 * 			<td>email</td>

 * 		</tr>

 * 		<tr>

 * 			<td>date</td>

 * 			<td>format character의 조합으로 이루어진 날자에 대한 패턴 스트링.<br>

 * 				<table>

 * 					<tr>

 * 						<td><b>format character</b></td>

 * 						<td><b>desc</b></td>

 * 					</tr>

 * 					<tr>

 * 						<td>YYYY</td>

 * 						<td>4자리 년도</td>

 * 					</tr>

 * 					<tr>

 * 						<td>YY</td>

 * 						<td>2자리 년도. 2000년 이후</td>

 * 					</tr>

 * 					<tr>

 * 						<td>MM</td>

 * 						<td>2자리 숫자의 달</td>

 * 					</tr>

 * 					<tr>

 * 						<td>DD</td>

 * 						<td>2자리 숫자의 일</td>

 * 					</tr>

 * 					<tr>

 * 						<td>hh</td>

 * 						<td>2자리 숫자의 시간. 12시 기준</td>

 * 					</tr>

 * 					<tr>

 * 						<td>HH</td>

 * 						<td>2자리 숫자의 시간. 24시 기준 </td>

 * 					</tr>

 * 					<tr>

 * 						<td>mm</td>

 * 						<td>2자리 숫자의 분</td>

 * 					</tr>

 * 					<tr>

 * 						<td>ss</td>

 * 						<td>2자리 숫자의 초</td>

 * 					</tr>

 * 				</table>

 * 			</td>

 * 			<td>날짜 검사. 입력된 스트링값을 날짜로 환산하여 유효한 날짜인지를 검사한다.</td>

 * 			<td>date=YYYYMMDD  일 때 입력값이 '20020328' 일 경우 -> 유효<br>

 *              date=YYYYMMDD  일 때 입력값이 '20020230' 일 경우 -> 오류<br>

 *              date=Today is YY-MM-DD' 일 때 입력값이 'Today is 02-03-28' 일 경우 -> 유효<br><br>

 * 				참고) format문자가 중복해서 나오더라도 처음 나온 문자에 대해서만 format문자로 인식된다.

 *                    YYYY와 YY, hh와 HH 도 중복으로 본다. 날짜는 년,월이 존재할 때만 정확히 체크하고

 *                    만일 년, 월이 없다면 1 ~ 31 사이인지만 체크한다.

 * 			</td>

 * 		</tr>

 * </table>

 * @sig    : value, validExp

 * @param  : value    required 검사 대상이 되는 값.

 * @param  : validExp required 사용자가 지정한 Valid Expression String.

 * @return : boolean. 유효성 여부.

 * @author : GAUCE

 */

function cfValidateValue(value, validExp) {

	var valueValidExp = new covValueValidExp(validExp);



	if (!valueValidExp.validate(value)) {

		return false;

	}



	return true;

}



/**

 * @type   : function

 * @access : public

 * @desc   : Grid의 선택된 Row들을 취소한다.

 * <pre>

 *     cfUndoGridRows(oDomRegiRecevGG);

 * </pre>

 * 위의 예에서 oDomRegiRecevGG의 현재 선택된 row들은 모두 취소된다.<br><br>

 * <font color=red>

 * 기존의 cfUndoGridRows 함수의 파라미터는 DataSet이었으나 파라미터가 Grid로 바뀌었다.

 * 하지만 기존에 파라미터를 DataSet으로 사용한 경우에도 변경없이 동작되도록 작성되었다.

 * </font>

 * @sig    : oGrid

 * @param  : oGrid required Grid 오브젝트

 * @author : GAUCE

 */

function cfUndoGridRows(obj) {

	if (obj.attributes.classid == null) {

		return;

	}



	var oDataSet;

	var oGrid;



	switch (obj.attributes.classid.nodeValue.toUpperCase()) {

		case "CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49": // DataSet Component

			oDataSet = obj;

			break;

		case "CLSID:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49": // Grid Component

			oGrid    = obj;

			oDataSet = document.all(oGrid.DataID);

			break;

	}



	if (oGrid != null && oGrid.MultiRowSelect == false) {

		oDataSet.Undo(oDataSet.RowPosition);

		return;

	} else {

		for (var i = oDataSet.CountRow; i > 0; i--) {

			if (oDataSet.RowMark(i)) {

				oDataSet.Undo(i);

			}

		}

	}

}



//---------------------------------------- 이하 객체선언 ------------------------------------------------------------------------------//



///////////////////////////// coMessage /////////////////////////////

/**

 * @type   : object

 * @access : private

 * @desc   : 메세지를 관리하는 객체이다.

 * @author : GAUCE

 */

function coMessage() {

	// method

	this.getMsg = coMessage_getMsg;

}



/**

 * @type   : method

 * @access : public

 * @object : coMessage

 * @desc   : 공통메세지에 정의된 메세지를 치환하여 알려준다.

 * @sig    : message[, paramArray]

 * @param  : message    required common.js의 공통 메세지 영역에 선언된 메세지 ID

 * @param  : paramArray optional 메세지에서 '@' 문자와 치환될 스트링 Array. (Array의 index와

 *           메세지 내의 '@' 문자의 순서가 일치한다.)

 * @return : 치환된 메세지 스트링

 */

function coMessage_getMsg(message, paramArray) {

	if (cfIsNull(message)) {

		return null;

	}



	var index = 0;

	var re = /@/g;

	var count = 0;



	if (paramArray == null) {

		return message;

	}



	while ( (index = message.indexOf("@", index)) != -1) {

		if (paramArray[count] == null) {

			paramArray[count] = "";

		}



		message = message.substr(0, index) + String(paramArray[count]) +

		          message.substring(index + 1);



		index = index + String(paramArray[count++]).length;

	}



	return message;

}



///////////////////////////// coGridColumn /////////////////////////////

/**

 * @type   : object

 * @access : private

 * @desc   : Grid 에 선언된 컬럼정보를 담고있는 객체이다.

 * @author : GAUCE

 */

function coGridColumn() {

	this.attrNames = new Array();

	this.attrValues = new Array();

	this.attrCnt = 0;



	// method

	this.hasAttribute = coGridColumn_hasAttribute;

	this.setAttribute = coGridColumn_setAttribute;

	this.getAttribute = coGridColumn_getAttribute

}



/**

 * @type   : method

 * @access : public

 * @object : coGridColumn

 * @desc   : 컬럼에 특정 속성이 정의되어 있는지 알려준다.

 * @sig    : attrName

 * @param  : attrName required 속성명

 * @return : 속성 존재여부

 */

function coGridColumn_hasAttribute(attrName) {

	for (var i = 0; i < this.attrCnt; i++) {

		if (attrName.toUpperCase() == this.attrNames[i].toUpperCase()) {

			return true;

		}

	}



	return false;

}



/**

 * @type   : method

 * @access : public

 * @object : coGridColumn

 * @desc   : 컬럼에 새로운 속성을 추가한다.

 * @sig    : attrName, attrValue

 * @param  : attrName required 속성명

 * @param  : attrValue required 속성값

 * @return : 속성 존재여부

 */

function coGridColumn_setAttribute(attrName, attrValue) {

	this.attrNames[this.attrCnt]  = attrName.toUpperCase();

	this.attrValues[this.attrCnt] = attrValue;

	this.attrCnt++;

}



/**

 * @type   : method

 * @access : public

 * @object : coGridColumn

 * @desc   : 컬럼의 특정 속성값을 알려준다.

 * @sig    : attrName

 * @param  : attrName required 속성명

 * @return : 속성값

 */

function coGridColumn_getAttribute(attrName) {

	for (var i = 0; i < this.attrCnt; i++) {

		if (this.attrNames[i] == attrName) {

			return this.attrValues[i];

		}

	}

}



///////////////////////////// coGridFormat /////////////////////////////

/**

 * @type   : object

 * @access : private

 * @desc   : Grid Format을 파싱한 후 정보를 저장한다.

 * @author : GAUCE

 */

function coGridFormat(format) {

	this.format = format;

	this.columns = new Array();



	// method

	this.existsColumn = coGridFormat_existsColumn;

	this.parse  = coGridFormat_parse;



	// initialize

	this.parse();

}



/**

 * @type   : method

 * @access : parse

 * @object : coGridFormat

 * @desc   : 파싱한다.

 */

function coGridFormat_parse() {

	var tagRE = /<(fc|c|g|fg|x|fx)>/i;

	var colAttrRE = /([\w_]+)\s*=\s*['"]?([^<'"\s,]+)/i;

	var gFormat = this.format;

	var tagMatch;

	var colAttrData;

	var colAttrMatch;

	var colAttrName;

	var colAttrValue;

	var colCnt = 0;



	while ((tagMatch = gFormat.match(tagRE)) != null) {

		this.columns[colCnt] = new coGridColumn();

		colAttrData = gFormat.substring(tagMatch.lastIndex, gFormat.indexOf("<", tagMatch.lastIndex));



		while ( (colAttrMatch = colAttrData.match(colAttrRE)) != null) {

			colAttrName = colAttrMatch[1].toUpperCase();

			colAttrValue = colAttrMatch[2];

			this.columns[colCnt].setAttribute(colAttrName, colAttrValue);

			colAttrData = colAttrData.substr(colAttrMatch.lastIndex);

		}



		gFormat = gFormat.substr(tagMatch.lastIndex);

		colCnt++;

	}

}



/**

 * @type   : method

 * @access : public

 * @object : coGridFormat

 * @desc   : Grid에 선언된 컬럼들 중에서 특정 colid를 가진 컬럼이 존재하는지를 알려준다.

 * @sig    : colId

 * @param  : colId required 속성명

 * @return : 컬럼 존재여부

 */

function coGridFormat_existsColumn(colId) {

	for (var i = 0; i < this.columns.length; i++) {

		if (this.columns[i].hasAttribute("ID") &&

		    this.columns[i].getAttribute("ID") == colId) {

			return true;

		}

	}



	return false;

}



///////////////////////////// coMap /////////////////////////////

/**

 * @type   : object

 * @access : public

 * @desc   : String parameter 에 대한 name과 value 쌍들을 가진 객체

 * @author : GAUCE

 */

function coMap() {

	// fields



	this.names = new Array();

	this.values = new Array();

	this.count = 0;



	// methods

	this.getValue          = coMap_getValue;

	this.put               = coMap_put;

	this.getNameAt         = coMap_getNameAt;

	this.getValueAt        = coMap_getValueAt;

	this.size              = coMap_size;

	this.getMaxNameLength  = coMap_getMaxNameLength;

}



/**

 * @type   : method

 * @access : public

 * @object : coMap

 * @desc   : name에 맞는 파라미터값을 리턴한다.

 * @sig    : name

 * @param  : name required map의 name으로 사용할 값

 * @return : 파라미터값

 */

function coMap_getValue(name) {

	for (var i = 0; i < this.count; i++) {

		if (this.names[i] == name) {

			return this.values[i];

		}

	}



	return null;

}



/**

 * @type   : method

 * @access : public

 * @object : coMap

 * @desc   : 새로운 map을 추가한다. 같은 name가 존재할 경우 overwrite한다.

 * @sig    : name, value

 * @param  : name  required map의 name로 사용할 값

 * @param  : value required map의 value로 사용할 값

 * @return : 파라미터값

 */

function coMap_put(name, value) {

	for (var i = 0; i < this.count; i++) {

		if (this.names[i] == name) {

			this.values[i] = value;

			return;

		}

	}



	this.names[this.count] = name;

	this.values[this.count++] = value;

}



/**

 * @type   : method

 * @access : public

 * @object : coMap

 * @desc   : 지정된 index에 있는 map의 name을 알려준다.

 * @sig    : index

 * @param  : index - map의 index

 * @return : name

 */

function coMap_getNameAt(index) {

	return this.names[index];

}



/**

 * @type   : method

 * @access : public

 * @object : coMap

 * @desc   : 지정된 index에 있는 map의 value를 알려준다.

 * @sig    : index

 * @param  : index required map의 index

 * @return : value

 */

function coMap_getValueAt(index) {

	return this.values[index];

}



/**

 * @type   : method

 * @access : public

 * @object : coMap

 * @desc   : map의 name-value 쌍의 갯수를 알려준다.

 * @return : name-value 쌍의 갯수

 */

function coMap_size() {

	return this.count;

}



/**

 * @type   : method

 * @access : public

 * @object : coMap

 * @desc   : map 내의 name 값들을 String으로 환산하여 최대길이를 알려준다.

 * @return : max name length

 */

function coMap_getMaxNameLength() {

	var maxLength = 0;



	for (var i = 0; i < this.count; i++) {

		if (String(this.names[i]).length > maxLength) {

			maxLength = String(this.names[i]).length;

		}

	}



	return maxLength;

}



///////////////////////////// coParameterMap /////////////////////////////

/**

 * @type   : object

 * @access : public

 * @desc   : String parameter 에 대한 name과 value 쌍들을 가진 객체

 * @author : GAUCE

 */

function coParameterMap() {

	// fields



	/**

	 * @type   : field

	 * @access : private

	 * @object : coParameterMap

	 * @desc   : 파라미터 이름을 담고있는 array

	 */

	this.names = new Array();



	/**

	 * @type   : field

	 * @access : private

	 * @object : coParameterMap

	 * @desc   : 파라미터 값을 담고있는 array

	 */

	this.values = new Array();



	/**

	 * @type   : field

	 * @access : private

	 * @object : coParameterMap

	 * @desc   : 파라미터의 개수

	 */

	this.count = 0;



	// methods

	this.getValue          = coParameterMap_getValue;

	this.put               = coParameterMap_put;

	this.getNameAt         = coParameterMap_getNameAt;

	this.getValueAt        = coParameterMap_getValueAt;

	this.size              = coParameterMap_size;

	this.getMaxNameLength  = coParameterMap_getMaxNameLength;

	this.getMaxValueLength = coParameterMap_getMaxValueLength;

}



/**

 * @type   : method

 * @access : public

 * @object : coParameterMap

 * @desc   : name에 맞는 파라미터값을 리턴한다.

 * @sig    : name

 * @param  : name required map의 name으로 사용할 값

 * @return : 파라미터값

 */

function coParameterMap_getValue(name) {

	for (var i = 0; i < this.count; i++) {

		if (this.names[i] == name) {

			return this.values[i];

		}

	}



	return null;

}



/**

 * @type   : method

 * @access : public

 * @object : coParameterMap

 * @desc   : 새로운 map을 추가한다. 같은 name가 존재할 경우 overwrite한다.

 * @sig    : name, value

 * @param  : name  required map의 name로 사용할 값

 * @param  : value required map의 value로 사용할 값

 * @return : 파라미터값

 */

function coParameterMap_put(name, value) {

	for (var i = 0; i < this.count; i++) {

		if (this.names[i] == name) {

			this.values[i] = value;

			return;

		}

	}



	this.names[this.count] = name;

	this.values[this.count++] = value;

}



/**

 * @type   : method

 * @access : public

 * @object : coParameterMap

 * @desc   : 지정된 index에 있는 map의 name을 알려준다.

 * @sig    : index

 * @param  : index required map의 index

 * @return : name

 */

function coParameterMap_getNameAt(index) {

	return this.names[index];

}



/**

 * @type   : method

 * @access : public

 * @object : coParameterMap

 * @desc   : 지정된 index에 있는 map의 value를 알려준다.

 * @sig    : index

 * @param  : index required map의 index

 * @return : value

 */

function coParameterMap_getValueAt(index) {

	return this.values[index];

}



/**

 * @type   : method

 * @access : public

 * @object : coParameterMap

 * @desc   : map의 name-value 쌍의 갯수를 알려준다.

 * @return : name-value 쌍의 갯수

 */

function coParameterMap_size() {

	return this.count;

}



/**

 * @type   : method

 * @access : public

 * @object : coParameterMap

 * @desc   : map 내의 name 값들을 String으로 환산하여 최대길이를 알려준다.

 * @return : max name length

 */

function coParameterMap_getMaxNameLength() {

	var maxLength = 0;



	for (var i = 0; i < this.count; i++) {

		if (String(this.names[i]).length > maxLength) {

			maxLength = String(this.names[i]).length;

		}

	}



	return maxLength;

}



/**

 * @type   : method

 * @access : public

 * @object : coParameterMap

 * @desc   : map 내의 value 값들을 String으로 환산하여 최대길이를 알려준다.

 * @return : max value length

 */

function coParameterMap_getMaxValueLength() {

	var maxLength = 0;



	for (var i = 0; i < this.count; i++) {

		if (String(this.values[i]).length > maxLength) {

			maxLength = String(this.values[i]).length;

		}

	}



	return maxLength;

}



//-------------------------- 유효성 검사를 위한 객체 선언 -----------------------------//

/*

 * @Validator 객체의 구조

 *   - 속성 : exception,   -> validity의 sub속성이다. validity가 true면 exception은 무조건 false이고

 *                            validity가 false인 경우 false의 원인이 exception인지 여부를 알려준다.

 *                            exception은 사용자 입력에 대한 실제 validation과는 무관한 에러를 의미한다.

 *                            true/false 중 하나.

 *            message,     -> 오류메세지를 담고 있다.

 *            validity,    -> 유효성검사결과를 담고 있다. true/false 중 하나.

 *            value        -> 유효성 검사 대상 값.

 *

 *   - 메소드 : validate() -> 유효성 검사를 수행한다.

 *                            유효할 경우, validity를 true로하고 true를 return하고

 *                            유효하지 않을 경우,  validity를 false로하고 false를 return하고

 *                            message에 오류메세지를 기술한다.

 *                            exception의 경우는 exception을 true로 하고 message에 메세지를 기술한다.

 *

 *   - 추가시 할일 :

 *     1) validator객체를 정의한다.

 *     2) covValidExp 객체의 getValidators 메소드에 validator객체를 등록한다.

 */



///////////////////////////// covValueValidExp /////////////////////////////

/**

 * @type   : object

 * @access : private

 * @desc   : 유효성 검사에 대한 표현(expression)을 객체화 하였다.

 *             - expression 형식<br>

 *               항목이름:필수항목여부:유효성항목<br>

 *               예) "접수번호:yes:length=6"

 *             - 유효성 항목 형식

 *               유효성항목명=유효값[&유효성항목명=유효값]..

 *               예) "length=13&ssn"

 * @sig    : expression

 * @param  : expression required valid expression string.

 * @author : GAUCE

 */

function covValueValidExp(expression) {

    // data;

    this.validItems = new Array();

    this.errMsg = "";



    // method

    this.init = covValueValidExp_init;

    this.parse = covValueValidExp_parse;

    this.validate = covValueValidExp_validate;



    // initialize

    this.init(expression);

}



/**

 * @type   : method

 * @access : private

 * @object : covValueValidExp

 * @desc   : 초기화를 수행한다.

 * @sig    : expression

 * @param  : expression required valid expression string.

 * @author : GAUCE

 */

function covValueValidExp_init(expression) {

	this.parse(expression);

}



/**

 * @type   : method

 * @access : private

 * @object : covValueValidExp

 * @desc   : covValidExp 객체의 parse 메소드.

 *           valid expression을 parsing한다.

 * @sig    : expression

 * @param  : expression required valid expression string.

 */

function covValueValidExp_parse(expression) {

	if (cfIsNull(expression)) {

		return;

	}



	var validItemExps = expression.advancedSplit("&", "i");

	var validItem;



	for (var i = 0; i < validItemExps.length; i++) {

		validItemPair = validItemExps[i].trim().advancedSplit("=", "i");

		validItem = new Object();

		validItem.name  = validItemPair[0].trim();

		validItem.value = validItemPair[1];  // parsedExp[1] 은 존재하지 않을 수도 있지만 자바스크립트에서는

		this.validItems[i] = validItem;      // 이런 경우 "undefined" 라는 값을 리턴한다.

	}

}



/**

 * @type   : method

 * @access : private

 * @object : covValueValidExp

 * @desc   : validation을 수행한다.

 * @sig    : value

 * @param  : value required 검사대상값

 */

function covValueValidExp_validate(value) {

	var validators = new Array();

	var count = 0;



	for (var i = 0; i < this.validItems.length; i++) {

		switch (this.validItems[i].name) {

			case "length" :

				validators[count++] = new covLengthValidator(this.validItems[i].value);

				break;



			case "byteLength" :

				validators[count++] = new covByteLengthValidator(this.validItems[i].value);

				break;



			case "minLength" :

				validators[count++] = new covMinLengthValidator(this.validItems[i].value);

				break;



			case "minByteLength" :

				validators[count++] = new covMinByteLengthValidator(this.validItems[i].value);

				break;



			case "maxLength" :

				validators[count++] = new covMaxLengthValidator(this.validItems[i].value);

				break;



			case "maxByteLength" :

				validators[count++] = new covMaxByteLengthValidator(this.validItems[i].value);

				break;



			case "number" :

				validators[count++] = new covNumberValidator(this.validItems[i].value);

				break;



			case "minNumber" :

				validators[count++] = new covMinNumberValidator(this.validItems[i].value);

				break;



			case "maxNumber" :

				validators[count++] = new covMaxNumberValidator(this.validItems[i].value);

				break;



			case "inNumber" :

				validators[count++] = new covInNumberValidator(this.validItems[i].value);

				break;



			case "minDate" :

				validators[count++] = new covMinDateValidator(this.validItems[i].value);

				break;



			case "maxDate" :

				validators[count++] = new covMaxDateValidator(this.validItems[i].value);

				break;



			case "format" :

				validators[count++] = new covFormatValidator(this.validItems[i].value);

				break;



			case "ssn" :

				validators[count++] = new covSsnValidator(this.validItems[i].value);

				break;



			case "csn" :

				validators[count++] = new covCsnValidator(this.validItems[i].value);

				break;



			case "filterIn" :

				validators[count++] = new covFilterInValidator(this.validItems[i].value);

				break;



			case "filterOut" :

				validators[count++] = new covFilterOutValidator(this.validItems[i].value);

				break;



			case "email" :

				validators[count++] = new covEmailValidator(this.validItems[i].value);

				break;



			case "date" :

				validators[count++] = new covDateValidator(this.validItems[i].value);

				break;



			default :

				break;

		}

	}



	for (var i = 0; i < validators.length; i++) {

		if (!validators[i].validate(value)) {

			this.errMsg = validators[i].message;

			return false;

		}

	}



	return true;

}



///////////////////////////// covItemValidExp /////////////////////////////

/**

 * @type   : object

 * @access : private

 * @desc   : 유효성 검사에 대한 표현(expression)을 객체화 하였다.

 *             - expression 형식<br>

 *               항목이름:필수항목여부:유효성항목<br>

 *               예) "접수번호:yes:length=6"

 *             - 유효성 항목 형식

 *               유효성항목명=유효값[&유효성항목명=유효값]..

 *               예) "length=13&ssn"

 * @sig    : expression, itemName

 * @param  : expression required valid expression string.

 * @param  : itemName   required 아이템명

 * @author : GAUCE

 */

function covItemValidExp(expression, itemName) {

    // data;

    this.itemName;

    this.required;

    this.valueValidExp;



    // method

    this.parse = covItemValidExp_parse;

    this.validate = covItemValidExp_validate;



    // initialize

    this.parse(expression, itemName);

}



/**

 * @type   : method

 * @access : public

 * @object : covItemValidExp

 * @desc   : valid expression을 parsing한다.

 * @sig    : expression, itemName

 * @param  : expression required valid expression string.

 * @param  : itemName   required 아이템명

 */

function covItemValidExp_parse(expression, itemName) {

	if (cfIsNull(expression)) {

		return;

	}



	var columns = expression.advancedSplit(":", "i");



	if (cfIsNull(columns[1])) {

		return;

	}



	if (cfIsNull(columns[0])) {

		if (!cfIsNull(itemName)) {

			this.itemName = itemName.trim();

		} else {

			return;

		}

	} else {

		this.itemName = columns[0].trim();

	}



	this.required = (columns[1].trim().toUpperCase() == "YES" ||

	                 columns[1].trim().toUpperCase() == "TRUE" ||

	                 columns[1].trim() == "1"

	                ) ? true : false;



	if ((columns[2]) != null) {

		this.valueValidExp = new covValueValidExp(columns[2].trim());

	}

}



/**

 * @type   : method

 * @access : public

 * @object : covItemValidExp

 * @desc   : validation을 수행한다.

 * @sig    : value

 * @param  : value required 검사할 값

 */

function covItemValidExp_validate(value) {

	// 표현식에 필수항목들(아이템명, 필수여부)을 기술하지 않을 경우는 표현식이 없다고 간주.

	if (cfIsNull(this.itemName) || cfIsNull(this.required)) {

		return true;

	}



	if (this.required && cfIsNull(value)) {

		this.errMsg = MSG_COM_ERR_002;

		return false;

	}



	if (!this.required && cfIsNull(value)) {

		return true;

	}



	if (this.valueValidExp == null) {

		return true;

	}



	if (!this.valueValidExp.validate(value)) {

		this.errMsg = this.valueValidExp.errMsg;

		return false;

	}



	return true;

}



///////////////////////////// covColumnValidExp /////////////////////////////

/**

 * @type   : object

 * @access : private

 * @desc   : Grid의 컬럼 유효성 검사 표현식

 * @sig    : expression, oGrid

 * @param  : expression required valid expression string.

 * @param  : oGrid      required 검사대상 Grid 오브젝트

 * @author : GAUCE

 */

function covColumnValidExp(expression, oGrid) {

    // data;

    this.colId;

    this.errMsg = "";

    this.errRow = -1;

    this.errItemName = "";

    this.itemValidExp;

    this.property = "NORMAL";  // NORMAL, KEY, SINGLEKEY 속성이 있다.



    // method

    this.parse    = covColumnValidExp_parse;

    this.validate = covColumnValidExp_validate;



    // initialize

    this.parse(expression, oGrid);

}



/**

 * @type   : method

 * @access : public

 * @object : covColumnValidExp

 * @desc   : valid expression을 parsing한다.

 * @sig    : expression, oGrid

 * @param  : expression required valid expression string.

 * @param  : oGrid      required 검사대상 Grid 오브젝트

 */

function covColumnValidExp_parse(expression, oGrid) {

	var index = -1;



	var expArr = expression.advancedSplit(":", "i");



	if (expArr.length < 3) {

		return;

	}



	var itemName = null;



	this.colId = expArr[0].trim();



	if (new coGridFormat(oGrid.Format).existsColumn(this.colId)) {

		itemName = oGrid.ColumnProp(this.colId, "Name");

	}



	this.itemValidExp = new covItemValidExp(expArr[1] + ":" + expArr[2] + ":" + expArr[3], itemName);

	if (!cfIsNull(expArr[4]) && expArr[4].toUpperCase().trim() == "KEY") {

		this.property = "KEY";

	} else if (!cfIsNull(expArr[4]) && expArr[4].toUpperCase().trim() == "SINGLEKEY") {

		this.property = "SINGLEKEY";

	}

}



/**

 * @type   : method

 * @access : public

 * @object : covColumnValidExp

 * @desc   : validation을 수행한다.

 * @sig    : oDataSet, row

 * @param  : oDataSet required 검사대상 DataSet

 * @param  : row required 검사대상 DataSet의 특정 row 번호

 */

function covColumnValidExp_validate(oDataSet, row) {

	if (oDataSet == null ||

	    oDataSet.tagName != "OBJECT" ||

	    oDataSet.attributes.classid.nodeValue.toUpperCase() !== "CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" ||

	    oDataSet.CountRow < 1

	   ) {

	   	return true;

	}



	var startIdx = 1;

	var endIdx = oDataSet.CountRow;

	var value;

	var rowYN = false;



	if (row != null) {

		startIdx = row;

		endIdx = row;

		rowYN = true;

	}



	for (var i = startIdx; i <= endIdx; i++) {

		value = (oDataSet.NameValue(i, this.colId) == null) ?

                 null : oDataSet.NameString(i, this.colId).trim();  // DataSet의 data를 trim 시킨다.



		if (this.itemValidExp != null && !this.itemValidExp.validate(value)) {

			this.errMsg = this.itemValidExp.errMsg;

			this.errRow = i;

			this.errItemName = this.itemValidExp.itemName;

			return false;

		}

	}



	return true;

}



///////////////////////////// covGridValidExp /////////////////////////////

/**

 * @type   : object

 * @access : private

 * @desc   : Grid에 대한 유효성검사 표현식

 * @sig    : oGrid

 * @param  : oGrid required 검사대상 Grid

 * @author : GAUCE

 */

function covGridValidExp(oGrid) {

    // data;

    this.oGrid = oGrid;

    this.columnValidExps = new Array();

	this.errMsg;

	this.errRow;

	this.errColId;

	this.errItemName = "";



    // method

    this.parse = covGridValidExp_parse;

    this.validate = covGridValidExp_validate;



    // initialize

    this.parse();

}



/**

 * @type   : method

 * @access : public

 * @object : covGridValidExp

 * @desc   : valid expression을 parsing한다.

 */

function covGridValidExp_parse() {

	if (cfIsNull(this.oGrid) || cfIsNull(this.oGrid.validExp)) {

		return;

	}



	var columns = this.oGrid.validExp.trim().advancedSplit(",", "it");



	for (var i = 0; i < columns.length; i++) {

    	this.columnValidExps[i] = new covColumnValidExp(columns[i], this.oGrid);

	}

}



/**

 * @type   : method

 * @access : public

 * @object : covGridValidExp

 * @desc   : validation을 수행한다.

 * @sig    : [row[, colId[, ignoreStatus]]]

 * @param  : row optional 검사대상 Grid의 특정 row 번호

 * @param  : colId optional 검사대상 Grid의 특정 컬럼의 id

 * @param  : ignoreStatus optional Grid 검사시 row status에 상관없이 모두 검사할 것인지의 여부.

 */

function covGridValidExp_validate(row, colId, ignoreStatus) {

	var oDataSet = document.all(this.oGrid.DataId);



	if (oDataSet == null ||

	    oDataSet.tagName != "OBJECT" ||

	    oDataSet.attributes.classid.nodeValue.toUpperCase() !== "CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" ||

	    oDataSet.CountRow < 1

	   ) {

	   	return true;

	}



	var startIdx;

	var endIdx;

	var nestedStartIdx;

	var nestedEndIdx;

	var keyColValidExps = new Array();

	var singleKeyColValidExps = new Array();



	// 키컬럼 추출

	var keyColCnt = 0;

	var singleKeyColCnt = 0;

	for (var i = 0; i < this.columnValidExps.length; i++) {

		if (this.columnValidExps[i].property == "KEY") {

			keyColValidExps[keyColCnt++] = this.columnValidExps[i];

		} else if (this.columnValidExps[i].property == "SINGLEKEY") {

			singleKeyColValidExps[singleKeyColCnt++] = this.columnValidExps[i];

		}

	}



	if (row != null) {

		startIdx = row;

		endIdx = row;

	} else {

		startIdx = 1;

		endIdx = oDataSet.CountRow - 1;

	}



	// 중복키 체크

	if (keyColValidExps.length > 0 || singleKeyColValidExps.length > 0) {

		var isEqual;



		for (var i = startIdx; i <= endIdx; i++) {



			if (row != null) {

				nestedStartIdx = 1;

			} else {

				nestedStartIdx = i + 1;

			}



			for (j = nestedStartIdx; j <= oDataSet.CountRow; j++) {

				if (i == j) {

					continue;

				}



				// 일반키컬럼 검사.

				{

					isEqual = true;

					for (var k = 0; k < keyColValidExps.length; k++) {

						if (oDataSet.NameValue(i, keyColValidExps[k].colId) !=

						    oDataSet.NameValue(j, keyColValidExps[k].colId)

						   ) {

						   	isEqual = false;

						   	break;

						}

					}



					if (isEqual) {

						this.errMsg = cfGetMsg(MSG_COM_ERR_032, ["@"]);



						if (row != null) {

							this.errRow = row;  // row를 지정하였을 때는 해당 row에 대한 error로 간주

						} else {

							this.errRow = j; // row지정이 없으면 중복된 두개의 데이터중 순서상 나중에 있는 row를 error로 간주

						}



						for (var k = 0; k < keyColValidExps.length; k++) {

							this.errItemName = this.errItemName + keyColValidExps[k].itemValidExp.itemName + ", ";

						}



						this.errItemName = this.errItemName.substring(0, this.errItemName.lastIndexOf(","));

						return false;

					}

				}



				// 싱글키컬럼 검사.

				for (var k = 0; k < singleKeyColValidExps.length; k++) {

					if (oDataSet.NameValue(i, singleKeyColValidExps[k].colId) ==

					    oDataSet.NameValue(j, singleKeyColValidExps[k].colId)

					   ) {

						this.errMsg = cfGetMsg(MSG_COM_ERR_032, ["@"]);



						if (row != null) {

							this.errRow = row;  // row를 지정하였을 때는 해당 row에 대한 error로 간주

						} else {

							this.errRow = j; // row지정이 없으면 중복된 두개의 데이터중 순서상 나중에 있는 row를 error로 간주

						}



						this.errItemName = singleKeyColValidExps[k].itemValidExp.itemName;

						return false;

					}

				}

			}

		}

	}



	if (row != null) {

		startIdx = row;

		endIdx = row;

	} else {

		startIdx = 1;

		endIdx = oDataSet.CountRow;

	}



	// validation 수행

	for (var i = startIdx; i <= endIdx; i++) {

		if (ignoreStatus || oDataSet.RowStatus(i) != 0) {

			for (var j = 0; j < this.columnValidExps.length; j++) {

				columnValidExp = this.columnValidExps[j];



				if (!columnValidExp.validate(oDataSet, i)) {

					this.errMsg = columnValidExp.errMsg;

					this.errRow = i;

					this.errColId = columnValidExp.colId;

					this.errItemName = columnValidExp.errItemName;

					return false;

				}

			}

		}

	}



	return true;

}



///////////////////////////// covLengthValidator /////////////////////////////

/**

 * @type   : object

 * @access : private

 * @desc   : 'length' 항목에 대한 validator. 값이 지정된 길이를 가지고 있는지 검사한다.

 * @param  : length required 유효한 기준길이.

 * @author : GAUCE

 */

function covLengthValidator(length) {

    // data;

    this.message = "";

    this.validity = false;

    this.length = length;



    // method

    this.validate = covLengthValidator_validate;

}



/**

 * @type   : method

 * @access : public

 * @object : covLengthValidator

 * @desc   : validation을 수행한다.

 * @sig    : value

 * @param  : value   required 유효성 검사 대상값.

 * @return : boolean. 유효성 여부.

 */

function covLengthValidator_validate(value) {

	if (value.length != this.length) {

		this.message = new coMessage().getMsg(MSG_COM_ERR_005, ["@", String(this.length)]);

		return false;

	}



	this.validity = true;

	return true;

}



///////////////////////////// covByteLengthValidator /////////////////////////////

/**

 * @type   : object

 * @access : private

 * @desc   : 'byteLength' 항목에 대한 validator. 값이 지정된 byte단위의 길이를 가지고 있는지 검사한다.

 * @param  : length required 유효한 기준길이.

 * @author : GAUCE

 */

function covByteLengthValidator(length) {

    // data;

    this.message = "";

    this.validity = false;

    this.length = length;



    // method

    this.validate = covByteLengthValidator_validate;

}



/**

 * @type   : method

 * @access : public

 * @object : covByteLengthValidator

 * @desc   : validation을 수행한다.

 * @sig    : value

 * @param  : value   required 유효성 검사 대상값.

 * @return : boolean. 유효성 여부.

 */

function covByteLengthValidator_validate(value) {

	if (cfGetByteLength(value) != this.length) {

		this.message = new coMessage().getMsg(MSG_COM_ERR_027, ["@", String(this.length), String(Math.floor(this.length / 2))]);

		return false;

	}



	this.validity = true;

	return true;

}



///////////////////////////// covMinLengthValidator /////////////////////////////

/**

 * @type   : object

 * @access : private

 * @desc   : 'minLength' 항목에 대한 validator. 값이 지정된 길이 이상인지를 검사한다.

 * @sig    : length

 * @param  : length required 유효한 기준길이.

 * @author : GAUCE

 */

function covMinLengthValidator(length) {

    // data;

    this.message = "";

    this.validity = false;

    this.length = length;



    // method

    this.validate = covMinLengthValidator_validate;

}



/**

 * @type   : method

 * @access : public

 * @object : covMinLengthValidator

 * @desc   : validation을 수행한다.

 * @sig    : value

 * @param  : value   required 유효성 검사 대상값.

 * @return : boolean. 유효성 여부.

 */

function covMinLengthValidator_validate(value) {

	if (value.length < this.length) {

		this.message = new coMessage().getMsg(MSG_COM_ERR_011, ["@", String(this.length)]);

		return false;

	}



	this.validity = true;

	return true;

}



///////////////////////////// covMinByteLengthValidator /////////////////////////////

/**

 * @type   : object

 * @access : private

 * @desc   : 'minByteLength' 항목에 대한 validator. 값이 지정된 byte단위의 길이 이상인지를 검사한다.

 * @sig    : length

 * @param  : length required 유효한 기준길이.

 * @author : GAUCE

 */

function covMinByteLengthValidator(length) {

    // data;

    this.message = "";

    this.validity = false;

    this.length = length;



    // method

    this.validate = covMinByteLengthValidator_validate;

}



/**

 * @type   : method

 * @access : public

 * @object : covMinByteLengthValidator

 * @desc   : validation을 수행한다.

 * @sig    : value

 * @param  : value   required 유효성 검사 대상값.

 * @return : boolean. 유효성 여부.

 */

function covMinByteLengthValidator_validate(value) {

	if (cfGetByteLength(value) < this.length) {

		this.message = new coMessage().getMsg(MSG_COM_ERR_028, ["@", String(this.length), String(Math.floor(this.length / 2))]);

		return false;

	}



	this.validity = true;

	return true;

}



///////////////////////////// covMaxLengthValidator /////////////////////////////

/**

 * @type   : object

 * @access : private

 * @desc   : 'maxLength' 항목에 대한 validator. 값이 지정된 길이 이상인지를 검사한다.

 * @sig    : length

 * @param  : length required 유효한 기준길이.

 * @author : GAUCE

 */

function covMaxLengthValidator(length) {

    // data;

    this.message = "";

    this.validity = false;

    this.length = length;



    // method

    this.validate = covMaxLengthValidator_validate;

}



/**

 * @type   : method

 * @access : public

 * @object : covMaxLengthValidator

 * @desc   : validation을 수행한다.

 * @sig    : value

 * @param  : value   required 유효성 검사 대상값.

 * @return : boolean. 유효성 여부.

 */

function covMaxLengthValidator_validate(value) {

	if (value.length > this.length) {

		this.message = new coMessage().getMsg(MSG_COM_ERR_012, ["@", String(this.length)]);

		return false;

	}



	this.validity = true;

	return true;

}



///////////////////////////// covMaxByteLengthValidator /////////////////////////////

/**

 * @type   : object

 * @access : private

 * @desc   : 'maxByteLength' 항목에 대한 validator. 값이 지정된 byte단위의 길이 이하인지를 검사한다.

 * @sig    : length

 * @param  : length required 유효한 기준길이.

 * @author : GAUCE

 */

function covMaxByteLengthValidator(length) {

    // data;

    this.message = "";

    this.validity = false;

    this.length = length;



    // method

    this.validate = covMaxByteLengthValidator_validate;

}



/**

 * @type   : method

 * @access : public

 * @object : covMaxByteLengthValidator

 * @desc   : validation을 수행한다.

 * @sig    : value

 * @param  : value   required 유효성 검사 대상값.

 * @return : boolean. 유효성 여부.

 */

function covMaxByteLengthValidator_validate(value) {

	if (cfGetByteLength(value) > this.length) {

		this.message = new coMessage().getMsg(MSG_COM_ERR_029, ["@", String(this.length), String(Math.floor(this.length / 2))]);

		return false;

	}



	this.validity = true;

	return true;

}



///////////////////////////// covNumberValidator /////////////////////////////

/**

 * @type   : object

 * @access : private

 * @desc   : 'number' 항목에 대한 validator. 값이 숫자인지를 검사한다. 또한 format을 지정하였을 경우에는 format에 맞는지 검사한다.

 * <pre>

 *     "number" 로 지정시 : 숫자인지 체크

 *     "number=(5.2)" 로 지정시 : 숫자이면서 정수부 5자리 이하, 소수부 2자리 이하인지를 체크

 * </pre>

 * @author : GAUCE

 */

function covNumberValidator(format) {

    // data;

	re = /\(\s*(\d+)\s*.\s*(\d+)\s*\)/;

	this.iLength;

	this.dLength;



	this.message = "";

	this.validity = false;



    // method

    this.validate = covNumberValidator_validate;



	// initialize

	{

		if (cfIsNull(format)) {

			return;

		}



		r = format.match(re);



		if (r == null) {

			return;

		}



		this.iLength = Number(r[1]);

		this.dLength = Number(r[2]);

	}

}



/**

 * @type   : method

 * @access : public

 * @object : covNumberValidator

 * @desc   : validation을 수행한다.

 * @sig    : value

 * @param  : value   required 유효성 검사 대상값.

 * @return : boolean. 유효성 여부.

 */

function covNumberValidator_validate(value) {

	if (isNaN(value)) {

		this.message = new coMessage().getMsg(MSG_COM_ERR_007, ["@"]);

		return false;

	} else if (!cfIsNull(this.iLength)) {

		var strValue = String(value);

		var idx = strValue.indexOf('.');

		var iNumStr = strValue.substr(0, idx);

		var dNumStr = strValue.substr(idx + 1);



		if (iNumStr.length > this.iLength) {

			this.message = new coMessage().getMsg(MSG_COM_ERR_059, ["@", String(this.iLength)]);

			return false;

		} else if (dNumStr.length > this.dLength) {

			this.message = new coMessage().getMsg(MSG_COM_ERR_060, ["@", String(this.dLength)]);

			return false;

		}

	}



	this.validity = true;

	return true;

}



///////////////////////////// covMinNumberValidator /////////////////////////////

/**

 * @type   : object

 * @access : private

 * @desc   : 'minNumber' 항목에 대한 validator. 값이 지정된 최소값을 넘는지를 검사한다.

 * @sig    : minNumber

 * @param  : minNumber required 유효한 기준 최소값.

 * @author : GAUCE

 */

function covMinNumberValidator(minNumber) {

    // data;

    this.message = "";

    this.validity = false;

    this.minNumber = minNumber;



    // method

    this.validate = covMinNumberValidator_validate;

}



/**

 * @type   : method

 * @access : public

 * @object : covMinNumberValidator

 * @desc   : validation을 수행한다.

 * @sig    : value

 * @param  : value   required 유효성 검사 대상값.

 * @return : boolean. 유효성 여부.

 */

function covMinNumberValidator_validate(value) {

	// 기준값이 숫자가 아닌경우 무조건 true;

	if (isNaN(this.minNumber)) {

		this.validity = true;

		return true;

	}



	if (isNaN(value)) {

		this.message = new coMessage().getMsg(MSG_COM_ERR_007, ["@"]);

		return false;

	}



	this.minNumber = Number(this.minNumber);

	value          = Number(value);



	if (value < this.minNumber) {

		this.message = new coMessage().getMsg(MSG_COM_ERR_013, ["@", String(this.minNumber)]);

		return false;

	}



	this.validity = true;

	return true;

}



///////////////////////////// covMaxNumberValidator /////////////////////////////

/**

 * @type   : object

 * @access : private

 * @desc   : 'maxNumber' 항목에 대한 validator. 값이 지정된 최대값을 넘지 않는지를 검사한다.

 * @sig    : maxNumber

 * @param  : maxNumber 유효한 기준 최대값.

 * @author : GAUCE

 */

function covMaxNumberValidator(maxNumber) {

    // data;

    this.message = "";

    this.validity = false;

    this.maxNumber = (maxNumber == null) ? "" : maxNumber.trim();



    // method

    this.validate = covMaxNumberValidator_validate;

}



/**

 * @type   : method

 * @access : public

 * @object : covMaxNumberValidator

 * @desc   : validation을 수행한다.

 * @sig    : value

 * @param  : value   required 유효성 검사 대상값.

 * @return : boolean. 유효성 여부.

 */

function covMaxNumberValidator_validate(value) {

	// 기준값이 숫자가 아닌경우 무조건 true;

	if (isNaN(this.maxNumber)) {

		this.validity = true;

		return true;

	}



	if (isNaN(value)) {

		this.message = new coMessage().getMsg(MSG_COM_ERR_007, ["@"]);

		return false;

	}



	this.maxNumber = Number(this.maxNumber);

	value          = Number(value);



	if (value > this.maxNumber) {

		this.message = new coMessage().getMsg(MSG_COM_ERR_014, ["@", String(this.maxNumber)]);

		return false;

	}



	this.validity = true;

	return true;

}





///////////////////////////// covInNumberValidator /////////////////////////////

/**

 * @type   : object

 * @access : private

 * @desc   : 'inNumber' 항목에 대한 validator. 값이 지정된 범위 내의 값인지를 검사한다.

 * @sig    : inNumber

 * @param  : inNumber required 숫자의 범위를 나타내는 스트링. 예) "1~100"

 * @author : GAUCE

 */

function covInNumberValidator(inNumber) {

    // data;

    this.message = "";

    this.validity = false;

    this.minNumber;

    this.maxNumber;



    // method

    this.validate = covInNumberValidator_validate;



    // initialize

	this.minNumber = inNumber.substring(0, inNumber.indexOf("~"));

	this.maxNumber = inNumber.substr(inNumber.indexOf("~") + 1);



	this.minNumber = (this.minNumber == null) ? "" : this.minNumber.trim();

	this.maxNumber = (this.maxNumber == null) ? "" : this.maxNumber.trim();

}



/**

 * @type   : method

 * @access : public

 * @object : covInNumberValidator

 * @desc   : validation을 수행한다.

 * @sig    : value

 * @param  : value   required 유효성 검사 대상값.

 * @return : boolean. 유효성 여부.

 */

function covInNumberValidator_validate(value) {

	// 기준값이 숫자가 아닌경우 무조건 true;

	if (isNaN(this.minNumber) || isNaN(this.maxNumber)) {

		this.validity = true;

		return true;

	}



	if (isNaN(value)) {

		this.message = new coMessage().getMsg(MSG_COM_ERR_007, ["@"]);

		return false;

	}



	this.minNumber = Number(this.minNumber);

	this.maxNumber = Number(this.maxNumber);

	value     = Number(value);



	if (value < this.minNumber || value > this.maxNumber) {

		this.message = new coMessage().getMsg(MSG_COM_ERR_006, ["@", String(this.minNumber), String(this.maxNumber)]);

		return false;

	}



	this.validity = true;

	return true;

}



///////////////////////////// covMinDateValidator /////////////////////////////

/**

 * @type   : object

 * @access : private

 * @desc   : 'minDate' 항목에 대한 validator. 값이 지정된 날짜를 넘는지를 검사한다.

 *           'YYYYMMDD' 형식으로 날짜를 표기해야 한다.

 *             예) minDate=20020315

 * @sig    : minDate

 * @param  : minDate required 유효한 기준 최소값.

 * @author : GAUCE

 */

function covMinDateValidator(minDate) {

    // data;

    this.message = "";

    this.validity = false;

    this.minDate = minDate;



    // method

    this.validate = covMinDateValidator_validate;

}



/**

 * @type   : method

 * @access : public

 * @object : covMinDateValidator

 * @desc   : validation을 수행한다.

 * @sig    : value

 * @param  : value   required 유효성 검사 대상값.

 * @return : boolean. 유효성 여부.

 */

function covMinDateValidator_validate(value) {

	if (!(new covDateValidator("YYYYMMDD").validate(value))) {

		this.message = new coMessage().getMsg(MSG_COM_ERR_018, ["@"]);

		return false;

	}



	if (value < this.minDate) {

		var msgParams = new Array(4);

		msgParams[0] = "@";

		msgParams[1] = this.minDate.substring(0,4);

		msgParams[2] = this.minDate.substring(4,5) == "0" ? this.minDate.substring(5,6) : this.minDate.substring(4,6);

		msgParams[3] = this.minDate.substring(6,7) == "0" ? this.minDate.substring(7,8) : this.minDate.substring(6,8)

		this.message = new coMessage().getMsg(MSG_COM_ERR_025, msgParams);

		return false;

	}



	this.validity = true;

	return true;

}



///////////////////////////// covMaxDateValidator /////////////////////////////

/**

 * @type   : object

 * @access : private

 * @desc   : 'maxDate' 항목에 대한 validator. 값이 지정된 최대값을 넘지 않는지를 검사한다.

 * @sig    : maxDate

 * @param  : maxDate required 유효한 최대날짜값.

 * @author : GAUCE

 */

function covMaxDateValidator(maxDate) {

    // data;

    this.message = "";

    this.validity = false;

    this.maxDate = maxDate;



    // method

    this.validate = covMaxDateValidator_validate;

}



/**

 * @type   : method

 * @access : public

 * @object : covMaxDateValidator

 * @desc   : validation을 수행한다.

 * @sig    : value

 * @param  : value   required 유효성 검사 대상값.

 * @return : boolean. 유효성 여부.

 */

function covMaxDateValidator_validate(value) {

	if (!(new covDateValidator("YYYYMMDD").validate(value))) {

		this.message = new coMessage().getMsg(MSG_COM_ERR_018, ["@"]);

		return false;

	}



	if (value > this.maxDate) {

		var msgParams = new Array(4);

		msgParams[0] = "@";

		msgParams[1] = this.maxDate.substring(0,4);

		msgParams[2] = this.maxDate.substring(4,5) == "0" ? this.maxDate.substring(5,6) : this.maxDate.substring(4,6);

		msgParams[3] = this.maxDate.substring(6,7) == "0" ? this.maxDate.substring(7,8) : this.maxDate.substring(6,8)

		this.message = new coMessage().getMsg(MSG_COM_ERR_024, msgParams);

		return false;

	}



	this.validity = true;

	return true;

}



///////////////////////////// covFormatValidator /////////////////////////////

/**

 * @type   : object

 * @access : private

 * @desc   : 'format' 항목에 대한 validator. 값이 마스크로 표현된 형식과 일치하는지 검사한다.

 *             - format characters

 *               #    : 문자와 숫자

 *               h, H : 한글 (H는 공백포함)

 *               A, Z : 문자 (Z는 공백포함)

 *               0, 9 : 숫자 (9는 공백포함)

 * @sig    : format

 * @param  : format required 포멧 스트링.

 * @author : GAUCE

 */

function covFormatValidator(format) {

    // data;

    this.message  = "";

    this.validity = false;

    this.format   = format



    // method

    this.validate = covFormatValidator_validate;

}



/**

 * @type   : method

 * @access : public

 * @object : covFormatValidator

 * @desc   : validation을 수행한다.

 * @sig    : value

 * @param  : value required 유효성 검사 대상값.

 * @return : boolean. 유효성 여부.

 */

function covFormatValidator_validate(value) {

	if (value.length != this.format.length) {

		this.message = new coMessage().getMsg(MSG_COM_ERR_026, ["@", this.format]);

		return false;

	}



	for (var i = 0; i < this.format.length; i++) {

		switch(this.format.charAt(i)) {

			case 'h' :

				var cCode = value.charCodeAt(i);

				if ( (value.charAt(i) == " ") ||

				     !((0xAC00 <= cCode && cCode <= 0xD7A3) || (0x3131 <= cCode && cCode <= 0x318E))

				   ) {

					this.message = new coMessage().getMsg(MSG_COM_ERR_026, ["@", this.format]);

					return false;

				}

				break;



			case 'H' :

				var cCode = value.charCodeAt(i);

				if ( (value.charAt(i) != " ") &&

				     !((0xAC00 <= cCode && cCode <= 0xD7A3) || (0x3131 <= cCode && cCode <= 0x318E))

				   ) {

					this.message = new coMessage().getMsg(MSG_COM_ERR_026, ["@", this.format]);

					return false;

				}

				break;



			case '0' :

				if (isNaN(value.charAt(i)) || value.charAt(i) == " ") {

					this.message = new coMessage().getMsg(MSG_COM_ERR_026, ["@", this.format]);

					return false;

				}

				break;



			case '9' :

				if (isNaN(value.charAt(i))) {

					if (value.charAt(i) != " ") {

						this.message = new coMessage().getMsg(MSG_COM_ERR_026, ["@", this.format]);

						return false;

					}

				}

				break;



			case 'A' :

				if ( (value.charAt(i) == " ") || !isNaN(value.charAt(i)) ) {

					this.message = new coMessage().getMsg(MSG_COM_ERR_026, ["@", this.format]);

					return false;

				}

				break;



			case 'Z' :

				if ( (value.charAt(i) != " ") && !isNaN(value.charAt(i)) ) {

					this.message = new coMessage().getMsg(MSG_COM_ERR_026, ["@", this.format]);

					return false;

				}

				break;



			case '#' :

				break;



			default :

				if (value.charAt(i) != this.format.charAt(i)) {

					this.message = new coMessage().getMsg(MSG_COM_ERR_026, ["@", this.format]);

					return false;

				}

				break;

		}

	}



	this.validity = true;

	return true;

}



///////////////////////////// covSsnValidator /////////////////////////////

/**

 * @type   : object

 * @access : private

 * @desc   : 'ssn' 항목에 대한 validator. 입력된 주민등록번호가 유효한지 검사한다.

 * @author : GAUCE

 */

function covSsnValidator() {

    // data;

    this.message = "";

    this.validity = false;



    // method

    this.validate = covSsnValidator_validate;

}



/**

 * @type   : method

 * @access : public

 * @object : covSsnValidator

 * @desc   : validation을 수행한다.

 * @sig    : ssn

 * @param  : ssn required 유효성 검사 대상값.

 * @return : boolean. 유효성 여부.

 */

function covSsnValidator_validate(ssn) {

	if ( ssn == null || ssn.trim().length != 13 || isNaN(ssn) )  {

		this.message = new coMessage().getMsg(MSG_COM_ERR_016, ["@"]);

		return false;

	}



	var jNum1 = ssn.substr(0, 6);

	var jNum2 = ssn.substr(6);



	/*

	  잘못된 생년월일을 검사합니다.
	  2000년도부터 성구별 번호가 바뀌였슴으로 구별수가 2보다 작다면
	  1900년도 생이되고 2보다 크다면 2000년도 이상생이 됩니다.
	  단 1800년도 생은 계산에서 제외합니다.

	*/
	bYear = (jNum2.charAt(0) <= "2") ? "19" : "20";

	// 주민번호의 앞에서 2자리를 이어서 4자리의 생년을 저장합니다.
	bYear += jNum1.substr(0, 2);


	// 달을 구합니다. 1을 뺀것은 자바스크립트에서는 1월을 0으로 표기하기 때문입니다.
	bMonth = jNum1.substr(2, 2) - 1;


	bDate = jNum1.substr(4, 2);


	bSum = new Date(bYear, bMonth, bDate);


	// 생년월일의 타당성을 검사하여 거짓이 있을시 에러메세지를 나타냄
	if ( bSum.getYear() % 100 != jNum1.substr(0, 2) || bSum.getMonth() != bMonth || bSum.getDate() != bDate) {
		this.message = new coMessage().getMsg(MSG_COM_ERR_016, ["@"]);

		return false;

	}

	total = 0;
	temp = new Array(13);


	for (i = 1; i <= 6; i++) {

		temp[i] = jNum1.charAt(i-1);

	}


	for (i = 7; i <= 13; i++) {

		temp[i] = jNum2.charAt(i-7);

	}


	for (i = 1; i <= 12; i++) {
		k = i + 1;


		// 각 수와 곱할 수를 뽑아냅니다. 곱수가 만일 10보다 크거나 같다면 계산식에 의해 2로 다시 시작하게 됩니다.
		if(k >= 10) k = k % 10 + 2;


		// 각 자리수와 계산수를 곱한값을 변수 total에 누적합산시킵니다.
		total = total + (temp[i] * k);
	}

	// 마지막 계산식을 변수 last_num에 대입합니다.
	last_num = (11- (total % 11)) % 10;


	// laster_num이 주민번호의마지막수와 같은면 참을 틀리면 거짓을 반환합니다.
	if(last_num != temp[13]) {

		this.message = new coMessage().getMsg(MSG_COM_ERR_016, ["@"]);

		return false;

	}


	this.validity = true;

	return true;

}



///////////////////////////// covCsnValidator /////////////////////////////

/**

 * @type   : object

 * @access : private

 * @desc   : 'csn' 항목에 대한 validator. 입력된 사업자등록번호가 유효한지 검사한다.

 * @author : GAUCE

 */

function covCsnValidator() {

    // data;

    this.message = "";

    this.validity = false;



    // method

    this.validate = covCsnValidator_validate;

}



/**

 * @type   : method

 * @access : public

 * @object : covCsnValidator

 * @desc   : validation을 수행한다.

 * @sig    : csn

 * @param  : csn required 유효성 검사 대상값.

 * @return : boolean. 유효성 여부.

 */

function covCsnValidator_validate(csn) {

	if ( csn == null || csn.length != 10 || isNaN(csn) )  {

		this.message = new coMessage().getMsg(MSG_COM_ERR_017, ["@"]);

		return false;

	}



	var sum = 0;

	var nam = 0;

	var checkDigit = -1;

	var checkArray = [1,3,7,1,3,7,1,3,5];



	for(i=0 ; i < 9 ; i++)

	  sum += csn.charAt(i) * checkArray[i];



	sum = sum + ((csn.charAt(8) * 5 ) / 10);



	nam = Math.floor(sum) % 10;



	checkDigit = ( nam == 0 ) ? 0 : 10 - nam;



	if ( csn.charAt(9) != checkDigit) {

		this.message = new coMessage().getMsg(MSG_COM_ERR_017, ["@"]);

		return false;

	}



	this.validity = true;

	return true;

}



///////////////////////////// covFilterInValidator /////////////////////////////

/**

 * @type   : object

 * @access : private

 * @desc   : 지정된 문자 이외에 다른 문자가 들어있을 경우 유효하지 않은 것으로 판단한다.

 *           특정 문자들에 대한 특수문자가 아래에 나와있다.<br>

 * <pre>

 *         ;    - \;

 *         한글 - \h

 *         영문 - \a

 *         숫자 - \n

 * </pre>

 * @sig    : fStr

 * @param  : fStr required filter에 대한 표현

 * @author : GAUCE

 */

function covFilterInValidator(fStr) {

    // data;

    this.message = "";

    this.validity = false;

    this.fStrArr = fStr.advancedSplit(";", "i");



    for (var i = 0; i < this.fStrArr.length; i++) {

    	if (this.fStrArr[i] == "\\h") {

    		this.fStrArr[i] = "한글";

    	} else if (this.fStrArr[i] == "\\a") {

    		this.fStrArr[i] = "영문";

    	} else if (this.fStrArr[i] == "\\n") {

    		this.fStrArr[i] = "숫자";

    	}

    }



    // method

    this.validate = covFilterInValidator_validate;

}



/**

 * @type   : method

 * @access : public

 * @object : covFilterInValidator

 * @desc   : validation을 수행한다.

 * @sig    : value

 * @param  : value required 유효성 검사 대상값.

 * @return : boolean. 유효성 여부.

 */

function covFilterInValidator_validate(value) {

	var isIn = false;

	var c

	var cCode;



	for (var i = 0; i < value.length; i++) {

		isIn = false;

		c = value.charAt(i);

		cCode = value.charCodeAt(i);



		for (var j = 0; j < this.fStrArr.length; j++) {

			if (this.fStrArr[j] == "한글" &&

			    ((0xAC00 <= cCode && cCode <= 0xD7A3) || (0x3131 <= cCode && cCode <= 0x318E))

			   ) {

				isIn = true;

			} else if ( this.fStrArr[j] == "영문" &&

			            ((0x61 <= cCode && cCode <= 0x7A) || (0x41 <= cCode && cCode <= 0x5A))

			          ) {

				isIn = true;

			} else if (this.fStrArr[j] == "숫자" && !isNaN(c)) {

				isIn = true;

			} else if (this.fStrArr[j] == c) {

				isIn = true;

			}

		}



		if (!isIn) {

			this.message = new coMessage().getMsg(MSG_COM_ERR_036, ["@", this.fStrArr.toString()]);

			return false;

		}

	}



	this.validity = true;

	return true;

}



///////////////////////////// covFilterOutValidator /////////////////////////////

/**

 * @type   : object

 * @access : private

 * @desc   : 지정된 스트링들이 들어있을 경우 유효하지 않은것으로 판단한다.

 *           분리자는 ";"를 사용한다. ";" 혹은 ";"문자가 들어간 스트링을 필터링하려 할 경우는

 *           "\\;"라고 표기해야 한다.

 * @sig    : fStr

 * @param  : fStr required filter에 대한 표현

 * @author : GAUCE

 */

function covFilterOutValidator(fStr) {

    // data;

    this.message = "";

    this.validity = false;

    this.fStrArr = fStr.advancedSplit(";", "i");



    // method

    this.validate = covFilterOutValidator_validate;

}



/**

 * @type   : method

 * @access : public

 * @object : covFilterValidator

 * @desc   : validation을 수행한다.

 * @sig    : value

 * @param  : value required 유효성 검사 대상값.

 * @return : boolean. 유효성 여부.

 */

function covFilterOutValidator_validate(value) {

	for (var i = 0; i < this.fStrArr.length; i++) {

		if (value.indexOf(this.fStrArr[i]) != -1) {

			this.message = new coMessage().getMsg(MSG_COM_ERR_033, ["@", "사용할수 없는 문자 : " + this.fStrArr.toString()]);

			return false;

		}

	}



	this.validity = true;

	return true;

}



///////////////////////////// covEmailValidator /////////////////////////////

/**

 * @type   : object

 * @access : private

 * @desc   : 입력값이 email 형식에 적합한지를 검사한다.

 * @author : GAUCE

 */

function covEmailValidator() {

    // data;

    this.message = "";

    this.validity = false;



    // method

    this.validate = covEmailValidator_validate;

}



/**

 * @type   : method

 * @access : public

 * @object : covEmailValidator

 * @desc   : validation을 수행한다.

 * @sig    : value

 * @param  : value required 유효성 검사 대상값.

 * @return : boolean. 유효성 여부.

 */

function covEmailValidator_validate(value) {

	var format = /^((\w|[\-\.])+)@((\w|[\-\.])+)\.([A-Za-z]+)$/;



	if (value.search(format) == -1) {

		this.message = new coMessage().getMsg(MSG_COM_ERR_037, ["@"]);

		return false;

	}



	this.validity = true;

	return true;

}



///////////////////////////// covDateValidator /////////////////////////////

/**

 * @type   : object

 * @access : private

 * @desc   : 값이 Date형식인지를 검사한다.

 *

 *            format문자 :  YYYY,  -> 4자리 년도

 *                          YY,    -> 2자리 년도. 2000년 이후.

 *                          MM,    -> 2자리 숫자의 달.

 *                          DD,    -> 2자리 숫자의 일.

 *                          hh,    -> 2자리 숫자의 시간. 12시 기준

 *                          HH,    -> 2자리 숫자의 시간. 24시 기준

 *                          mm,    -> 2자리 숫자의 분.

 *                          ss     -> 2자리 숫자의 초.

 *

 *            예)

 *                'YYYYMMDD' -> '20020328'

 *                'YYYY/MM/DD' -> '2002/03/28'

 *                'Today : YY-MM-DD' -> 'Today : 02-03-28'

 *

 *            참고)

 *                  format문자가 중복해서 나오더라도 처음 나온 문자에 대해서만

 *                  format문자로 인식된다. YYYY와 YY, hh와 HH 도 중복으로 본다.

 *                  날짜는 년,월이 존재할 때만 정확히 체크하고 만일 년, 월이 없다면

 *                  1 ~ 31 사이인지만 체크한다.

 *

 * @sig    : dateExp

 * @param  : dateExp required Date Format expression.

 *             예) 2002년 3월 12일 -> "YYYY-MM-DD"(Date Format Expression) -> "2002-03-12"

 * @author : GAUCE

 */

function covDateValidator(dateExp) {

    // data;

    this.message = "";

    this.validity = false;

    this.dateExp = dateExp;

    this.year = null;

    this.month = null;



    // method

    this.validate = covDateValidator_validate;

    this.checkLength = covDateValidator_checkLength;

    this.checkYear = covDateValidator_checkYear;

    this.checkMonth = covDateValidator_checkMonth;

    this.checkDay = covDateValidator_checkDay;

    this.checkHour = covDateValidator_checkHour;

    this.checkMin = covDateValidator_checkMin;

    this.checkSec = covDateValidator_checkSec;

    this.checkRest = covDateValidator_checkRest;

}



/**

 * @type   : method

 * @access : public

 * @object : covDateValidator

 * @desc   : validation을 수행한다.

 * @sig    : value

 * @param  : value   required 검사대상이 되는 Date 스트링 값.

 * @return : boolean - 유효성 여부

 */

function covDateValidator_validate(value) {

	this.value = value;



	if ( this.checkLength(value) &&

		 this.checkYear(value) &&

		 this.checkMonth(value) &&

		 this.checkDay(value) &&

		 this.checkHour(value) &&

		 this.checkMin(value) &&

		 this.checkSec(value) &&

		 this.checkRest(value)

	   ) {

		this.validity = true;

		return true;

	} else {

		this.validity = false;

		return false;

	}

}



function covDateValidator_checkLength() {

	if (this.value.length == this.dateExp.length) {

		return true;

	} else {

		this.message = new coMessage().getMsg(MSG_COM_ERR_005, ["@", String(this.dateExp.length)]);

		return false;

	}

}



function covDateValidator_checkYear() {

	var index = -1;



	if ( (index = this.dateExp.indexOf("YYYY")) != -1 ) {

		subValue = this.value.substr(index, 4);

		if ( !isNaN(subValue) &&

			 (subValue > 0)

		   ) {

			this.dateExp = this.dateExp.cut(index, 4);

			this.value = this.value.cut(index, 4);

			this.year = subValue;

			return true;

		} else {

			this.message = new coMessage().getMsg(MSG_COM_ERR_015, ["@"]);

			return false;

		}

	}



	if ( (index = this.dateExp.indexOf("YY")) != -1 ) {

		subValue = "20" + this.value.substr(index, 2);

		if ( !isNaN(subValue) &&

			 (subValue > 0)

		   ) {

			this.dateExp = this.dateExp.cut(index, 2);

			this.value = this.value.cut(index, 2);

			this.year = subValue;

			return true;

		} else {

			this.message = new coMessage().getMsg(MSG_COM_ERR_015, ["@"]);

			return false;

		}

	}



	return true;

}



function covDateValidator_checkMonth() {

	var index = -1;



	if ( (index = this.dateExp.indexOf("MM")) != -1 ) {

		subValue = this.value.substr(index, 2);

		if ( !isNaN(subValue) &&

		     (subValue > 0) &&

		     (subValue <= 12)

		   ) {

			this.dateExp = this.dateExp.cut(index, 2);

			this.value = this.value.cut(index, 2);

			this.month = subValue;

			return true;

		} else {

			this.message = new coMessage().getMsg(MSG_COM_ERR_019, ["@"]);

			return false;

		}

	}



	return true;

}



function covDateValidator_checkDay() {

	var index = -1;

	var days = 0;



	if ( (index = this.dateExp.indexOf("DD")) != -1 ) {

		if ( (this.year != null) && (this.month != null) ) {

			days = (this.month != 2) ? GLB_DAYS_IN_MONTH[this.month-1] : (( (this.year % 4) == 0 && (this.year % 100) != 0 || (this.year % 400) == 0 ) ? 29 : 28 );

		} else {

			days = 31;

		}



		subValue = this.value.substr(index, 2);

		if ( (!isNaN(subValue)) &&

		     (subValue > 0) &&

		     (subValue <= days)

		   ) {

			this.dateExp = this.dateExp.cut(index, 2);

			this.value = this.value.cut(index, 2);

			return true;

		} else {

			this.message = new coMessage().getMsg(MSG_COM_ERR_020, ["@"]);

			return false;

		}

	}



	return true;

}



function covDateValidator_checkHour() {

	var index = -1;



	if ( (index = this.dateExp.indexOf("hh")) != -1 ) {

		subValue = this.value.substr(index, 2);

		if ( !isNaN(subValue) &&

		     (subValue >= 0) &&

		     (subValue <= 12)

		   ) {

			this.dateExp = this.dateExp.cut(index, 2);

			this.value = this.value.cut(index, 2);

			return true;

		} else {

			this.message = new coMessage().getMsg(MSG_COM_ERR_021, ["@"]);

			return false;

		}

	}



	if ( (index = this.dateExp.indexOf("HH")) != -1 ) {

		subValue = this.value.substr(index, 2);

		if ( !isNaN(subValue) &&

		     (subValue >= 0) &&

		     (subValue < 24)

		   ) {

			this.dateExp = this.dateExp.cut(index, 2);

			this.value = this.value.cut(index, 2);

			return true;

		} else {

			this.message = new coMessage().getMsg(MSG_COM_ERR_021, ["@"]);

			return false;

		}

	}



	return true;

}



function covDateValidator_checkMin() {

	var index = -1;



	if ( (index = this.dateExp.indexOf("mm")) != -1 ) {

		subValue = this.value.substr(index, 2);

		if ( !isNaN(subValue) &&

		     (subValue >= 0) &&

		     (subValue < 60 )

		   ) {

			this.dateExp = this.dateExp.cut(index, 2);

			this.value = this.value.cut(index, 2);

			this.month = subValue;

			return true;

		} else {

			this.message = new coMessage().getMsg(MSG_COM_ERR_022, ["@"]);

			return false;

		}

	}



	return true;

}



function covDateValidator_checkSec() {

	var index = -1;



	if ( (index = this.dateExp.indexOf("ss")) != -1 ) {

		subValue = this.value.substr(index, 2);

		if ( (!isNaN(subValue)) &&

		     (subValue >= 0) &&

		     (subValue < 60 )

		   ) {

			this.dateExp = this.dateExp.cut(index, 2);

			this.value = this.value.cut(index, 2);

			this.month = subValue;

			return true;

		} else {

			this.message = new coMessage().getMsg(MSG_COM_ERR_023, ["@"]);

			return false;

		}

	}



	return true;

}



function covDateValidator_checkRest() {

	if (this.value == this.dateExp) {

		return true;

	}



	return false;

}





///////////////////////////// covNullValidator /////////////////////////////

/**

 * @type   : object

 * @access : private

 * @desc   : 무조건 valid한 결과를 가진 validator.

 * @author : GAUCE

 */

function covNullValidator() {

    // data;

    this.message = "";

    this.validity = true;



    // method

    this.validate = covNullValidator_validate;

}



/**

 * @type   : method

 * @access : public

 * @object : covNullValidator

 * @desc   : validation을 수행한다.

 * @return : boolean - 무조건 true.

 */

function covNullValidator_validate() {

	this.message = new coMessage().getMsg(MSG_COM_INF_007);

	return true;

}



// ---------------------------------- login과 관련된 스크립트입니다. ------------------------------ //

// 부분 웹모드를 위하여 일부 로직 수정 2003.2.27



/**

 * @type   : function

 * @access : public

 * @desc   : 환경 설정 가우스 데이터셋의 값을 호출한다.

 * @return : 해당 필드 값

 * @author : GAUCE

 */



function cfGetLoginGlobalSerttingObj( fieldName )

{



  var settingFrame = getMenuFrame();



  return settingFrame.oGlobalSettingGDS.NameString(1,fieldName);

}





/**

 * @type   : function

 * @access : public

 * @desc   : 현재 로그인 사용자의 사용자아이디를 반환한다.

 * @return : 사용자아이디(userId)

 * @author : GAUCE

 */

function cfGetLoginUserId()

{

  return cfGetLoginGlobalSerttingObj("userId");

}



/**

 * @type   : function

 * @access : public

 * @desc   : 현재 로그인 사용자의 사용자명을 반환한다.

 * @return : 사용자명(userNm)

 * @author : GAUCE

 */

function cfGetLoginUserNm()

{

  return cfGetLoginGlobalSerttingObj("userNm");

}



/**

 * @type   : function

 * @access : public

 * @desc   : 현재 로그인 사용자의 등기용국기호를 반환한다.

 * @return : 등기용국기호(regiPoCd)

 * @author : GAUCE

 */

function cfGetLoginRegiPoCd()

{



  return cfGetLoginGlobalSerttingObj("regiPoCd");

}



/**

 * @type   : function

 * @access : public

 * @desc   : 현재 로그인 사용자의 등기용국기호명을 반환한다.

 * @return : 등기용국기호명(regiPoCdNm)

 * @author : GAUCE

 */

function cfGetLoginRegiPoCdNm()

{

  return cfGetLoginGlobalSerttingObj("regiPoCdNm");

}



/**

 * @type   : function

 * @access : public

 * @desc   : 현재 로그인 사용자의 과코드명을 반환한다.

 * @return : 과코드명(deptCdNm)

 * @author : GAUCE

 */

function cfGetLoginDeptCdNm()

{

  return cfGetLoginGlobalSerttingObj("deptCdNm");

}



 /**

 * @type   : function

 * @access : public

 * @desc   : 현재 로그인 사용자의 과코드를 반환한다.

 * @return : 과코드(deptCd)

 * @author : GAUCE

 */

function cfGetLoginDeptCd()

{

  return cfGetLoginGlobalSerttingObj("deptCd");

}





 /**

 * @type   : function

 * @access : public

 * @desc   : 현재 로그인 사용자의 계코드명을 반환한다.

 * @return : 계코드명(sectCdNm)

 * @author : GAUCE

 */

function cfGetLoginSectCdNm()

{

  return cfGetLoginGlobalSerttingObj("sectCdNm");

}



 /**

 * @type   : function

 * @access : public

 * @desc   : 현재 로그인 사용자의 계코드를 반환한다.

 * @return : 계코드(sectCd)

 * @author : GAUCE

 */

function cfGetLoginSectCd()

{

  return cfGetLoginGlobalSerttingObj("sectCd");

}



 /**

 * @type   : function

 * @access : public

 * @desc   : 현재 로그인 사용자의 직책코드를 반환한다.

 * @return : 직책코드(posCd)

 * @author : GAUCE

 */

function cfGetLoginPosCd()

{

  return cfGetLoginGlobalSerttingObj("posCd");

}



 /**

 * @type   : function

 * @access : public

 * @desc   : 현재 로그인 사용자의 직책코드명을 반환한다.

 * @return : 직책코드명(posCdNm)

 * @author : GAUCE

 */

function cfGetLoginPosCdNm()

{

  return cfGetLoginGlobalSerttingObj("posCdNm");

}







 /**

 * @type   : function

 * @access : public

 * @desc   : 현재 로그인 사용자의 상위결재자아이디를 반환한다.

 * @return : 상위결재자아이디(hrnkSancPrsnID)

 * @author : GAUCE

 */

function cfGetLoginHrnkSancPrsnID()

{

  return cfGetLoginGlobalSerttingObj("hrnkSancPrsnID");

}



 /**

 * @type   : function

 * @access : public

 * @desc   : 현재 로그인 사용자의 업체코드를 반환한다.

 * @return : 업체코드(compCd)

 * @author : GAUCE

 */

function cfGetLoginCompCd()

{

  return cfGetLoginGlobalSerttingObj("compCd");

}



 /**

 * @type   : function

 * @access : public

 * @desc   : 현재 로그인 사용자의 내/외부사용자구분코드를 반환한다.

 * @return : 내/외부사용자구분코드(insOutUserGbCd)

 * @author : GAUCE

 */

function cfGetLoginInsOutUserGbCd()

{

  return cfGetLoginGlobalSerttingObj("insOutUserGbCd");

}







 /**

 * @type   : function

 * @access : public

 * @desc   : 현재 로그인 사용자의 감독국 접속 IP 를 반환한다.

 * @return : 감독국 IP

 * @author : GAUCE

 */

function cfGetLoginUserMPOIP( )

{

 return cfGetLoginGlobalSerttingObj("mpoip");

}



 /**

 * @type   : function

 * @access : public

 * @desc   : 현재 로그인 사용자의 접속 IP 를 반환한다.

 * @return : 접속IP

 * @author : GAUCE

 */

function cfGetLoginUserRemoteAddr( )

{

 return cfGetLoginGlobalSerttingObj("remoteAddr");

}



 /**

 * @type   : function

 * @access : public

 * @desc   : 현재 로그인 사용자의 UPDATE사용자정보를 반환한다.

 * @return : 접속IP

 * @author : GAUCE

 */

function cfGetLoginUserUpdateID( )

{

 return cfGetLoginGlobalSerttingObj("updateID");

}





/**

 * @type   : function

 * @access : public

 * @desc   : 현재 로그인 사용자의 공통정보를 표시한다.

 * @author : GAUCE

 */

function cfGetLoginShowGlobalSertting() {



   alert(

         '===== 사용자 공통 정보 =====\n'+

         '사용자아이디['+cfGetLoginUserId()+']\n'+

         '사용자명['+cfGetLoginUserNm()+']\n'+

         '등기용국기호['+cfGetLoginRegiPoCd()+']\n'+

         '등기용국기호명['+cfGetLoginRegiPoCdNm()+']\n'+

         '과코드명['+cfGetLoginDeptCdNm()+']\n'+

         '과코드['+cfGetLoginDeptCd()+']\n'+

         '계코드['+cfGetLoginSectCd()+']\n'+

         '계코드명['+cfGetLoginSectCdNm()+']\n'+

         '직책코드['+cfGetLoginPosCd()+']\n'+

         '직책코드명['+cfGetLoginPosCdNm()+']\n'+

         '상위결재자아이디['+cfGetLoginHrnkSancPrsnID()+']\n'+

         '업체코드['+cfGetLoginCompCd()+']\n'+

         '내/외부사용자구분코드['+cfGetLoginInsOutUserGbCd()+']\n'+

         '감독국IP['+cfGetLoginUserMPOIP()+']\n'+

         '접속IP['+cfGetLoginUserRemoteAddr()+']\n'+

         'UPDATE사용자정보['+cfGetLoginUserUpdateID()+']'

        );

 }





var MenuFrameGlobal ;



function checkOpenerExist( checkName ) {



  try {

      MenuFrameGlobal = checkName.top.MainFrame.MenuFrame ;

      return true ;

  }catch ( e ) {

      return false ;

  }



}



function checkMainExist() {



  try {



      MenuFrameGlobal = top.MainFrame.MenuFrame ;

      return true ;

  } catch ( e ) {

      return false ;

  }



}



function getLegalMenuFrame() {

 // var checkName = top.opener ;



  if ( !checkMainExist() ) {

    var checkName = self ;

    while ( !checkOpenerExist(checkName) ) {

    	checkName = checkName.top.opener ;

    }

  }



  return MenuFrameGlobal ;

}



var ServerHiddenMenuFrameGlobal ;



function checkServerHiddenExist() {



  try {



      ServerHiddenMenuFrameGlobal = top.ServerHiddenFrame ;

      return true ;

  } catch ( e ) {

      return false ;

  }



}



function checkServerHiddenOpenerExist( checkName ) {



  try {

      ServerHiddenMenuFrameGlobal = checkName.top.ServerHiddenFrame ;

      return true ;

  }catch ( e ) {

      return false ;

  }



}



function getCrossMenuFrame() {



  if ( !checkServerHiddenExist() ) {


       var checkName = self ;

       while ( !checkServerHiddenOpenerExist(checkName) ) {

    	   checkName = checkName.top.opener ;

       }
  }



  return ServerHiddenMenuFrameGlobal ;

}


function checkServerDomain() {
 try {
  if ( document.domain != null && document.domain != ""  ) return true ;
  else return false ;
 } catch ( exception )  {
  return false ;
 }
}


var TargetMenuFrameGlobal ;



function checkTargetOpenerExist( checkName ) {



  try {

      TargetMenuFrameGlobal = checkName.top.MainFrame.MenuFrame ;

      return true ;

  }catch ( e ) {

      return false ;

  }



}



function checkTargetMainExist() {



  try {



      TargetMenuFrameGlobal = top.MainFrame.MenuFrame ;

      return true ;

  } catch ( e ) {

      return false ;

  }



}



function getTargetMenuFrame() {



  if ( !checkTargetMainExist() ) {

  // open window 또는 dialog 라는 의미
   try {
       var checkName = self ;

       while ( !checkTargetOpenerExist(checkName) ) {

    	   checkName = checkName.top.opener ;

       }
   } catch ( exception ) {
       // opener 를 찾는 과정에서 오류가 나면 dialog 라는 의미
       TargetMenuFrameGlobal = self ;
   }

  }



  return TargetMenuFrameGlobal ;

}




function checkCrossFrame()

{

  try {
    var targetFrame = getTargetMenuFrame() ;
    if ( document.domain == targetFrame.document.domain ) return false ;

    else return true ;
   }catch( Exception ) {

    return true ;

  }

}









function getMenuFrame() {

  if ( checkServerDomain() ) {

       if ( checkCrossFrame() ) return getCrossMenuFrame();

       else return getLegalMenuFrame() ;

  } else {
    return getLegalMenuFrame() ;
  }

}



 /**

 * @type   : function

 * @access : public

 * @desc   : 현재 로그인 사용자에게  해당 직무코드가 있는지 체크 한다.

 * @return : boolean - 직무코드가 있을 경우 true

 * @author : GAUCE

 */

function cfExistLoginUserRoleCode( roleCode )

{

  var dataArray = cfGetLoginUserRoleCodeList();

  var size = dataArray.length ;

  for ( var inx =0 ; inx < size ; inx++ ) {



      if ( dataArray[inx] == roleCode ) return true ;

  }



  return false  ;

}

/**

 * @type   : function

 * @access : public

 * @desc   : 커서모양을 바꾸어 주는 함수

 * @param  : theType  커서모양

 *          0 : 디폴트(화살표)

 *          1 : 모래시계

 *          2 : 도움말

 *          3 : 손모양

 * @author : GAUCE

 */

var arrayInput  = "";	// INPUT TAG 배열...

var arrayCombo = "";			// 코드콤보 TAG 배열...

var arrayObject = "";			// 가우스 오브젝트 배열...

var arrayA = "";					// A TAG배열...

var useChangeCursor = "false";

function cfChangeCursor(param)

{
	switch(param) {

		case 0:
			theType = "default";
			break;

		case 1:
			theType = "wait";
			break;

		case 2:
			theType = "help";
			break;

		case 3:
			theType = "hand";
			break;

		default:
			theType = "default";
			break;
	}

	var i;

	var tagList = document.all.tags("body");



	for (i=0; i < tagList.length; i++) {

		if (tagList[i].tagName == "BODY") {

			tagList[i].style.cursor = theType;

			break;

		}

	}



	// INPUT TAG시 설정..

	var tagList = document.all.tags("input");

	if (param != 0) {

		arrayInput = new Array(tagList.length);

	}



	for (i=0; i < tagList.length; i++) {

		tagList[i].style.cursor = theType;

		if (param != 0) {

			arrayInput[i] = tagList[i].disabled;

			tagList[i].disabled = true;

		} else {

			tagList[i].disabled = arrayInput[i];

		}

	}



	// A TAG시 설정..

	var tagList = document.all.tags("a");

	if (param != 0) {

		arrayA = new Array(tagList.length);

	}



	for (i=0; i < tagList.length; i++) {

		tagList[i].style.cursor = theType;

		if (param != 0) {

			arrayA[i] = tagList[i].disabled;

			tagList[i].disabled = true;

		} else {

			tagList[i].disabled = arrayA[i];

		}

	}



	// 가우스 오브젝트 배열..

	var tagList = document.all.tags("OBJECT");

	if (param != 0) {

		arrayObject = new Array(tagList.length);

	}



	for (i=0; i < tagList.length; i++) {

		tagList[i].style.cursor = theType;

		if (param != 0) {
			useChangeCursor =  true;
			arrayObject[i] = tagList[i].Enable;

			switch(tagList[i].classid.toUpperCase()) {

				case "CLSID:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49": // 그리드.
						tagList[i].Enable = "false";
						break;

				case "CLSID:FD4C6571-DD20-11D2-973D-00104B15E56F": // CodeCombo Component
						tagList[i].Enable = "false";
						break;

				case "CLSID:14DA1FE5-438E-4E2C-959D-5BF03F63EA9C": // CodeCombo2 Component
						tagList[i].Enable = "false";
						break;

				case "CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0": // Radio Component
						tagList[i].Enable = "false";
						break;

                case "CLSID:91B0A4F0-3206-4564-9BB4-AF9055DEF8A1": // TextArea Component
						tagList[i].Enable = "false";
						break;

				case "CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03": // InputFile Component
						tagList[i].Enable = "false";
						break;

				case "CLSID:E6876E99-7C28-43AD-9088-315DC302C05F": // EMedit Component
						tagList[i].Enable = "false";
						break;

				case "CLSID:B5F6727A-DD38-11D2-973D-00104B15E56F": // Chart Component
						tagList[i].Enable = "false";
						break;

				case "CLSID:BCB3A52D-F8E7-11D3-973E-0060979E2A03": // ImageData Component
						tagList[i].Enable = "false";
						break;

				case "CLSID:ED382953-E907-11D3-B694-006097AD7252": // Tab Component
						tagList[i].Enable = "false";
						break;

				case "CLSID:4401B994-DD33-11D2-B539-006097ADB678": // TreeView Component
						tagList[i].Enable = "false";
						break;

				case "CLSID:7A54CBF0-2CB4-11D4-973E-0060979E2A03": // Menu Component
						tagList[i].Enable = "false";
						break;

				case "CLSID:8D6D8F1E-2567-4916-8036-50D3F7F01563": // Scale Component
						tagList[i].Enable = "false";
						break;

			}

		} else {

			switch(tagList[i].classid.toUpperCase()) {

				case "CLSID:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49": // 그리드.
						tagList[i].Enable = arrayObject[i];
						break;

				case "CLSID:FD4C6571-DD20-11D2-973D-00104B15E56F": // CodeCombo Component
						tagList[i].Enable = arrayObject[i];
						break;

				case "CLSID:14DA1FE5-438E-4E2C-959D-5BF03F63EA9C": // CodeCombo2 Component
						tagList[i].Enable = arrayObject[i];
						break;

				case "CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0": // Radio Component
						tagList[i].Enable = arrayObject[i];
						break;

                case "CLSID:91B0A4F0-3206-4564-9BB4-AF9055DEF8A1": // TextArea Component
						tagList[i].Enable = arrayObject[i];
						break;

				case "CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03": // InputFile Component
						tagList[i].Enable = arrayObject[i];
						break;

				case "CLSID:E6876E99-7C28-43AD-9088-315DC302C05F": // EMedit Component
						if (tagList[i].text != "데이터가 없습니다.")
						{
							tagList[i].Enable = arrayObject[i];
						}
						break;

				case "CLSID:B5F6727A-DD38-11D2-973D-00104B15E56F": // Chart Component
						tagList[i].Enable = arrayObject[i];
						break;

				case "CLSID:BCB3A52D-F8E7-11D3-973E-0060979E2A03": // ImageData Component
						tagList[i].Enable = arrayObject[i];
						break;

				case "CLSID:ED382953-E907-11D3-B694-006097AD7252": // Tab Component
						tagList[i].Enable = arrayObject[i];
						break;

				case "CLSID:4401B994-DD33-11D2-B539-006097ADB678": // TreeView Component
						tagList[i].Enable = arrayObject[i];
						break;

				case "CLSID:7A54CBF0-2CB4-11D4-973E-0060979E2A03": // Menu Component
						tagList[i].Enable = arrayObject[i];
						break;

				case "CLSID:8D6D8F1E-2567-4916-8036-50D3F7F01563": // Scale Component
						tagList[i].Enable = arrayObject[i];
						break;

			}

//			tagList[i].Enable = arrayObject[i];

		}

	}

}



 /**

 * @type   : function

 * @access : public

 * @desc   : 동적메뉴 구성 여부

 * @author : GAUCE

 */


function checkDynamicMenu( ) {
  return true  ;

  //return false  ;



  if ( checkServerDomain() ) return true ;

  else return false ;
}





/*

 작업처리중 팝업 화면을 열고 / 닫는 로직 구현

*/



var popUpProgressWindowWidth = 300 ;

var popUpProgressWindowLeftPos = Math.ceil((screen.width - popUpProgressWindowWidth) / 2 );

var popUpProgressWindowHeight = 100;

var popUpProgressWindowTopPos =  Math.ceil((screen.height - popUpProgressWindowHeight) / 2 );



var dialogProgressWindowWidth = "310px" ;

var dialogProgressWindowLeftPos = Math.ceil((screen.width - popUpProgressWindowWidth) / 2 );

var dialogProgressWindowHeight = "130px";

var dialogProgressWindowTopPos =  Math.ceil((screen.height - popUpProgressWindowHeight) / 2 );





function fncAlertMessage() {

   alert('닫기 단추(X)를 누르지마십시오') ;

   fncProgressWinOpen();

}



 /**

 * @type   : function

 * @access : public

 * @desc   : 작업중 윈도우 표시

 * @author : GAUCE

 */



 function fncProgressWinOpen( ) {



   document.documentElement.disabled = true ;
    alert("STEP-1");
   window.showModalDialog( GLB_URL_COMMON_PAGE + "/progress_forward.html", self ,"dialogLeft:"+popUpProgressWindowLeftPos+"; dialogTop:"+popUpProgressWindowTopPos+" ;dialogWidth:"+dialogProgressWindowWidth+"; dialogHeight:"+dialogProgressWindowHeight+" " );

   cfChangeCursor( 1 ) ;


}



 /**

 * @type   : function

 * @access : public

 * @desc   : 작업중 윈도우 종료

 * @author : GAUCE

 */

function fncProgressWinClose() {



  document.documentElement.disabled = false ;

  cfChangeCursor( 0 ) ;

  try {

    popUpProgressWindowReference = window.open( "","wait_please","top=2000,left=2000,width=1,height=1,menubar=no,status=no,titlebar=no" );
    popUpProgressWindowReference.closeWin();

  }catch( Exception ){

    // 윈도우가 이미 닫힌 경우 그냥 무시한다.

  }
}





/**

 * @type   : function

 * @access : public

 * @desc   : 변경된 데이터가 있는데 다른 메뉴를 클릭하는 경우 html body의 onbeforeunload event에서

 *           다른메뉴로 이동할것인지(cfChangeDataChk 함수호출) 아닌지에 대한 확인 메세지를 준다

 * @sig    : oDataSetId

 * @param  : oDataSetId 변경유무를 확인하려고하는 데이터셋 이름

 * @return :

 * <pre>

 *     oDataSet : 변경유무를 확인하려고하는 데이터셋 이름

 *     사용예) <body onbeforeunload="cfChangeDataChk(oDataSet)">

 * </pre>

 * @author : 조부구

 */



function cfChangeDataChk(oDataSetId) {

	if (oDataSetId.isUpdated){

		event.returnValue = "변경사항이 반영되지 않았습니다.";

	}

}



/**
 * @type   : function
 * @access : public
 * @desc   : 그리드 상에서 enter를 key를 치는 경우 tab 처럼 옆으로 아래로 이동한다.
 *           이동의 기준은 edit가능한 칼럼 단위로 이동한다.
 *           그리드의 onkeypress event에서 호출 하면 된다. (keycode 13이면 enter 키이다.)
 * @sig    : oGrid
 * @param  : oGrid enter key 처리할 그리드 object id
 * @return :
 * <pre>
 *     사용예)
 *     oGrid : object id
 *     <script language=JavaScript for=oGrid event=OnKeyPress(kcode)>
 * 		if ( kcode == '13' ) // key code 13은 enter key
 *			fncGridEnterKey(oGrid);
 *     </script>
 * </pre>
 * @author : 조부구
 */

function fncGridEnterKey(oGrid) {
	TempGDS = document.createElement("<OBJECT>");
	TempGDS.classid = "CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49";
	TempGDS.id = "TempGDS";

	for (var j = 0; j < document.all.length; j++) {
		if (document.all[j].tagName == "HEAD") {
			document.all[j].insertAdjacentElement("beforeEnd", TempGDS);
			break;
		}
	}

	curDataSet  = document.all(oGrid.DataID);

	var tagRE = /<(fc|c|g|fg|x|fx)>/i;
	var colAttrRE = /([\w_]+)\s*=\s*['"]?([^<'"\s,]+)/i;
	var gFormat = oGrid.Format;
	var newGFormat = "";
	var tagMatch;
	var tagName;
	var colAttrData;
	var colAttrMatch;
	var colAttrName;
	var colAttrValue;
	var insertStr;
	var newFormat ="";

	// Grid Format String 을 파싱하여 컬럼별로 Style 과 관련된 속성을 삽입한다.
	while ((tagMatch = gFormat.match(tagRE)) != null) {
		var gridColid ="";
		var editstyle ="";
		var showFalse ="";

		// 사용자가 지정한 컬럼 속성에 따른 처리
		colAttrData = gFormat.substring(tagMatch.lastIndex, gFormat.indexOf("<", tagMatch.lastIndex));

		while ( (colAttrMatch = colAttrData.match(colAttrRE)) != null) {
				colAttrName = colAttrMatch[1].toUpperCase();
			if ( colAttrName == "ID" ){
				gridColid = colAttrMatch[2].toUpperCase();
			}
			else if ( colAttrName == "EDIT" ){
				editstyle = colAttrMatch[2].toUpperCase();
			}
			else if ( colAttrName == "SHOW" ){
				showFalse = colAttrMatch[2].toUpperCase();
			}
			colAttrData = colAttrData.substr(colAttrMatch.lastIndex);
		}

		colAttrData = gFormat.substring(tagMatch.lastIndex, gFormat.indexOf("<", tagMatch.lastIndex));

		gFormat = gFormat.substr(tagMatch.lastIndex);

		curColIndex   = curDataSet.ColumnIndex(gridColid);  		//column id에 해당하는 index값
		curColProp	  = curDataSet.ColumnProp(curColIndex);     // 0:"NORMAL", 1:"CONSTANT", 2:"KEYVALUE"(변경안됨)

		tagName = tagMatch[1].trim().toUpperCase();

		if ( tagName =='C' || tagName =='FC' ){
			if ( editstyle != "NONE" && curColProp != "2" && showFalse != "FALSE" ){
				newFormat = newFormat + gridColid+',';
			}
		}
	}

	TempGDS.setdataheader(newFormat); //그리드 format에 해당하는 칼럼 순서로 temp의 데이터 셋을 생성한다.
								 	  //데이터셋과 그리드의 칼럼 순서가 불일치...
	var currColumn    = oGrid.GetColumn();
	var currColummIdx = TempGDS.ColumnIndex(currColumn);  //현재선택된 칼럼의 index
	var CurrRowNoChg  = 'Y';

	for (var i = 1; i <= TempGDS.CountColumn; i++) {
		colId      = TempGDS.ColumnID(i);	      //column id
		colIndex   = TempGDS.ColumnIndex(colId);  //column id에 해당하는 index값
		colProp	   = TempGDS.ColumnProp(i);       // 0:"NORMAL", 1:"CONSTANT", 2:"KEYVALUE"(변경안됨)
		editStatus = oGrid.ColumnProp(colId,"edit");

		if ( currColummIdx < colIndex ) {
			oGrid.focus();
			oGrid.SetColumn(colId);
			return;
		}
	}

	//enter event 마지막 row인경우는 다음 row로 이동한다.
	if ( CurrRowNoChg == 'Y' ){
		curDataSet.RowPosition =  curDataSet.RowPosition + 1;

		for (var i = 1; i <= TempGDS.CountColumn; i++) {
			colId      = TempGDS.ColumnID(i);	      //column id
			colIndex   = TempGDS.ColumnIndex(colId);  //column id에 해당하는 index값
			colProp	   = TempGDS.ColumnProp(i);       // 0:"NORMAL", 1:"CONSTANT", 2:"KEYVALUE"(변경안됨)
			editStatus = oGrid.ColumnProp(colId,"edit");

			oGrid.focus();
			oGrid.SetColumn(colId);
			return;
		}
	}
}

 /**
 * @type   : function
 * @access : public
 * @desc   : 다운로드시에 총괄국 서버를 사용할 것인지 여부를 결정 한다.
 * @author : GAUCE
 */

function fncUseMPOServer() {
 // 총괄국 서버를 사용할 경우 return true 로 변경
 return false ;
}


function ln_Excel_file()
 {
       var g_RetVal;
       var g_PrmVal;
       var g_PrmVal = "" + "|" + "";

    	g_RetVal = window.showModalDialog("excel_p01.html",
		                               g_PrmVal,
	                              "unadorned:off;help:off; dialogHide:off;resizable:off;status:off;dialogWidth:302px; dialogHeight:150px;");
		return g_RetVal;
 }

//==========  엑셀로 저장시
function ln_Excel(obj,title){
//	var tbgd_Excel=

        obj.SetExcelTitle(0, "");
	TitleText = "value:" + title + ";font-face:굴림체;font-size:30pt;font-color:black;font-bold;font-underline;bgcolor:#CCFFCC;align: center;line-color:#C0C0C0;line-width:0.5pt;skiprow:1;";
	obj.SetExcelTitle(1, TitleText);
	var today = new Date();
	var day = today.getDay();
	var week;
	if (day==0) {week="일요일";}
	else if (day==1) {week="월요일";}
	else if (day==2) {week="화요일";}
	else if (day==3) {week="수요일";}
	else if (day==4) {week="목요일";}
	else if (day==5) {week="금요일";}
	else if (day==6) {week="토요일";}
	var hour = today.getHours();
	if (hour>12) {hour="오후 "+(hour-12);}
  else {hour="오전 "+hour;}
  var minute = today.getMinutes();
  var second = today.getSeconds();

	var ymd = today.getYear() +"년 "+ (today.getMonth() + 1) +"월 "+ today.getDate() + "일"
  var hms = hour + "시 " + minute + "분 " +  second + "초";
  TitleText = "value : 출력일자 : " + ymd + " ("+ week + ")";
  TitleText+= "\n" + hms;
	TitleText+= "; font-face: '굴림체';font-size: 12pt;font-color:#336600;font-italic;bgcolor:#ffffff;align:right;line-color: #C0C0C0;line-width:0.5pt;skiprow: 1;";
	obj.SetExcelTitle(1, TitleText);

	var g_Excelfile_type ="0";

	g_Excelfile_type = ln_Excel_file();

    if (g_Excelfile_type == undefined ){//엑셀로 받기
        obj.GridtoExcel(title,"",1);
    }else if (g_Excelfile_type =="1"){//파일로 받기
			//obj.ExportFile(title,'true');
		obj.GridtoExcel(title,title,29);
	}else if (g_Excelfile_type =="2"){//엑셀로 받기
			obj.GridtoExcel(title,"",1);
	}else if (g_Excelfile_type =="3"){//텍스트 파일 저장시 사용함
			obj.ExportFileEx(title+'.txt', true, 1, false);
	}else{
		return;
	}
}

/*===========================================================================*/
// return first object value about pObjName's paramemr
/*===========================================================================*/
function getObjectFirst(pObjName)	{
	return document.getElementsByName(pObjName)[0];
}

/*===========================================================================*/
// return first object value about pObjName's paramemr
/*===========================================================================*/
function getObjectList(pObjName, pDoc)	{

	var tObjDoc = document;
	if (pDoc != null)	{
		tObjDoc = pDoc;
	}

	return tObjDoc.getElementsByName(pObjName);

}

/*===========================================================================
 * IE 패치에 따른 함수 추가
 ===========================================================================*/
function __ws__(id){
	document.write(id.innerHTML);
	id.id = "";
}

/*===========================================================================*/
// 문자열을 치환한 후 결과값을 반환한다.
/*===========================================================================*/
function replaceStr(pStr, pFind, pReplace)	{

	// 패턴 선언(해당 문자를 모두 찾아서 변환해줌).
	var newPattern = new RegExp(pFind, "gi");

	return pStr.replace(newPattern, pReplace);
}

/*===========================================================================*/
// 그리드의 해당값에 해당하는 곳의 Row를 찾아서, Focus를 이동
/*===========================================================================*/
function fnFindGridDataNSetFocus(pObjDataSet, pObjGrid, pFindData, pCompColId, pSetColId)
{
	var vMatchRow = 1;

	for (i=1; i<=pObjDataSet.CountRow; i++)
	{
		if (pFindData == pObjDataSet.NameString(i, pCompColId))
		{
			vMatchRow = i;
			break;
		}
	}
	pObjDataSet.RowMark(1) = 0;
	
	pObjGrid.SetScrolling(vMatchRow, 1);
	pObjGrid.SetColumn(pSetColId);
	pObjGrid.Focus();
	pObjDataSet.RowMark(vMatchRow) = 1;
	pObjDataSet.RowPosition = vMatchRow;
}

/*===========================================================================*/
// 값이 비어있는지를 체크하여 비어있으면 해당 메세지를 보여준다.
// 값이 비어있을 경우 true를 반환한다.
/*===========================================================================*/
function isEmpty(pObject, pMsg, pLen, pLenFlag)	
{

	//----------
	// FM : 필수입력이고 data길이가 fix된 경우
	//  M : 필수입력이고 data길이가 초과된 경우
	// NM : data길이가 초과된 경우만
	//----------

	//alert(pObject.outerHTML);
	if (pLenFlag == null) pLenFlag = "";

	if (pObject.tagName.toUpperCase() == "INPUT" || pObject.tagName.toUpperCase() == "TEXTAREA")	
	{
		if ( pLenFlag =="" && pObject.value=="")	
		{
			if (pMsg)	alert("[" + pMsg + "]를(을) 입력하세요 !!!");

			if(pObject.disabled==false) pObject.focus();
			return true;
		}
		else if (pLenFlag=="FM" && pLen && getByteLength(pObject) !=pLen )	
		{
			alert("[" + pMsg +"]의 길이가 맞지 않습니다.\n\n해당 항목의 길이는 " + pLen +"자 입니다.\n(한글은 2바이트 영문/숫자는 1바이트로 계산됩니다.)");
			pObject.focus();
			pObject.select();
			return true;
		}
		else if (pLenFlag=="M" && pLen && getByteLength(pObject) == 0 )	
		{
			alert("[" + pMsg +"]를(을) 입력하세요 !!!");
			if(pObject.disabled==false) 
			{
				pObject.focus();
				pObject.select();
			}
			return true;
		}
		else if (pLenFlag=="M" && pLen && getByteLength(pObject) > pLen )	
		{
			alert("[" + pMsg +"]의 길이가 너무 깁니다.\n\n해당 항목의 길이는 " + pLen +"바이트를 초과할 수 없습니다.\n(한글은 2바이트 영문/숫자는 1바이트로 계산됩니다.)");
			pObject.focus();
			pObject.select();
			return true;
		}
		else if (pLenFlag=="NM" && pLen && getByteLength(pObject) > pLen )	
		{
			alert("[" + pMsg +"]의 길이가 너무 깁니다.\n\n해당 항목의 길이는 " + pLen +"바이트를 초과할 수 없습니다.\n(한글은 2바이트 영문/숫자는 1바이트로 계산됩니다.)");
			pObject.focus();
			pObject.select();
			return true;
		}

	}
	else if (pObject.tagName.toUpperCase() == "SELECT")	
	{
		if (pObject.selectedIndex == 0 && pObject.value=="")	
		{
			if (pMsg)	alert("[" + pMsg + "]를(을) 선택하세요 !!!");

			pObject.focus();
			return true;
		}
	}
	else	
	{
		alert("매개변수로 넘어온 객체가 INPUT 타입이 아닙니다.");
		return true;
	}

	return false;
}

/*===========================================================================*/
// byte로 리턴
/*===========================================================================*/
function getByteLength(input) 
{
    var byteLength = 0;
    for (var inx = 0; inx < input.value.length; inx++) 
    {
        var oneChar = escape(input.value.charAt(inx));
        if ( oneChar.length == 1 ) byteLength ++;
        else if (oneChar.indexOf("%u") != -1) byteLength += 2;
        else if (oneChar.indexOf("%") != -1) byteLength += oneChar.length/3;
    }
    return byteLength;
}

/**
  * 함 수 명 : ln_TRSetting()
  * 매개변수 : 없슴
  * 설    명 : Transation Parameter Setting
  */
function ln_TRSetting(a_TR, a_TR_ACTION,a_TR_KEYVALUE, a_TR_PARAMETERS )
{

	a_TR.ServerIP   = ""              ;
   	a_TR.Action     = a_TR_ACTION     ;
   	a_TR.KeyName    = "Toinb_dataid4" ;
   	a_TR.KeyValue   = a_TR_KEYVALUE   ;
   	a_TR.Parameters = a_TR_PARAMETERS ;

}

/**
  * 함 수 명 : tr_post()
  * 매개변수 : 없슴
  * 설    명 : Transation Post
  */
function tr_post(a_TR)
{
	a_TR.post();
}	

/*
 * Progress Bar Start
 */
function fnOnProgressStart(){
    window.status="잠시만 기다려 주시길바랍니다.";
//    getObjectFirst("LowerFrame").style.visibility="visible";
}

/*
 * Progress Bar End
 */
function fnOnProgressEnd(){
    window.status="조회가 완료되었습니다..";
    getObjectFirst("LowerFrame").style.visibility="hidden";
}

/**
 * 주민등록 번호를 체크한다.
 * @param obj1 주민번호 앞자리(1~6)
 * @param obj2 주민번호 뒷자리(7~13)
 * @author 안준성
 * @history 1.0, 2001-11-27
 */
function fnJuminNoCheck( obj1 ) {
//alert(obj1);
    var tmp = 0
    var yy = obj1.substring(0,2)
    var mm = obj1.substring(2,4)
    var dd = obj1.substring(4,6)
    var sex = obj1.substring(6,7)
            
    if ((obj1.length != 13 ) || ( mm < 1 || mm > 12 || dd < 1) ) {
        alert ("주민등록번호를 정확히 입력해 주세요.");
        return false;
    }
/*    if ((sex != 1 && sex !=2 && sex !=3 && sex !=4))   {
        alert ("주민등록번호를 정확히 입력해 주세요.");
        return false;
    }*/

    for (var i = 0; i <=11 ; i++)
       tmp = tmp + ((i%8+2) * parseInt(obj1.substring(i,i+1)))

    tmp = 11 - (tmp %11)
    tmp = tmp % 10
//alert(tmp + " : " + sex);
    if (tmp != obj1.substring(12))
    {
        alert ("잘못된 주민등록번호입니다.");
        return false;
    }

    return true;
}

function cfLengthCheck(targetObj, maxLength) {
    var len = 0;
    var newtext = "";
    for(var i=0 ; i < targetObj.value.length; i++) {
        var c = escape(targetObj.value.charAt(i));

        if ( c.length == 1 ) len ++;
        else if ( c.indexOf("%u") != -1 ) len += 2;
        else if ( c.indexOf("%") != -1 ) len += c.length/3;

        if( len <= maxLength ) newtext += unescape(c);
    }

    if ( len > maxLength ) {
        targetObj.value = newtext;
        targetObj.focus();
        return false;
    }
}

/*
 * 
 */

var v_year      = "";
var v_month     = "";
var v_day       = "";
var v_hour      = "";
var v_minute    = "";
var v_second    = "";

function fnSetDate(){
    var v_today     = new Date();
    v_year          = v_today.getYear()+"";
    v_month         = v_today.getMonth()+1+"";
    v_day           = v_today.getDate()+"";
    v_hour          = v_today.getHours()+"";
    v_minute        = v_today.getMinutes()+"";
    v_second        = v_today.getSeconds()+"";

    if(v_month<10)    v_month   = "0"+ v_month;
    if(v_day<10)      v_day     = "0"+ v_day;
    if(v_hour<10)     v_hour    = "0"+ v_hour;
    if(v_minute<10)   v_minute  = "0"+ v_minute;
    if(v_second<10)   v_second  = "0"+ v_second;
}

function fnGetYear(){
    fnSetDate();
    return v_year;
}
function fnGetMonth(){
    fnSetDate();
    return v_month;
}

function fnGetDate(){
    fnSetDate();
    return v_year+v_month+v_day;
}

function fnGetTime(){
    fnSetDate();
    return v_hour+v_minute+v_second;
}

/**
 * 일반전화 및 휴대전화번호 포맷 정의
 */
function fnTelNoFormat(objName){
    if(getObjectFirst(objName).Text.trim().length>1){
        if(getObjectFirst(objName).Text.trim().substring(0, 2) == "01")
            getObjectFirst(objName).Format = "000-0000-0000";
        else if(getObjectFirst(objName).Text.trim().substring(0, 2) == "02")
            getObjectFirst(objName).Format = "00-0000-0000";
        else
            getObjectFirst(objName).Format = "000-000-0000";
    }
}
var GRID_LINK_COLOR = "#1579C7";
var ROOT = "/officedata";
