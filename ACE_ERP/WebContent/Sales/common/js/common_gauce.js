/*
 ***********************************************
 * @source      : common.js
 * @description : �����ڹٽ�ũ��Ʈ
 ***********************************************
 * DATE         AUTHOR    DESCRIPTION
 * ---------------------------------------------
 *
 ***********************************************
*/

/**
 * @type : intro
 * @desc : common.js�� ������Ʈ ���ݿ� ���� �� �ý��ۿ��� �������� ����ϴ� �ڹ� ��ũ��Ʈ�� �����
 * �ڹٽ�ũ��Ʈ �����̴�. ����� ���Ǵ� �ڹٽ�ũ��Ʈ���� ȭ�鸶�� �ݺ������� ���ߵ���
 * �ʵ��� �̸� ���ǵǾ� �־ common.js�� ����ȭ�鿡 import��Ű�⸸ �ϸ� common.js�� ���ǵǾ�
 * �ִ� ��ũ��Ʈ�鿡 ���ؼ��� �� �����ڰ� ������ ������ �ʿ䰡 ����.
 * common.js �ҽ��� 2���� �������� �����Ǿ���.
 * <pre>
 *     1. ���� �޼��� ����   : ȭ�鿡 ���Ǵ� ����� �޼������� ������ ����
 *     2. ���� ��ũ��Ʈ ���� : ȭ�鿡 ���Ǵ� ���� ��ũ��Ʈ���� ����� ����
 * </pre>
 * �Լ� Naming Rule�� ������ ����.
 * <pre>
 *     - cf  : common function
 *     - co  : common object
 *     - cov : common object for validation
 * </pre>
 * <font color=red>�����ǻ���</font>
 * <pre>
 *     - common.js�� import�ϴ� html ȭ�鿡���� object id�� ������ ��, ������ ������ id��
 *       ������ �� �����ϴ�.
 *
 *       coTreeViewImageComnGIDS
 * </pre>
 * @version : 3.6
 * @change  :
 * <pre>
 *     <font color="blue">V3.6</font>
 *     - cfGetCurrentDate �Լ��� �������� ����ǵ��� ����.
 *     - cfStyleGrid ���� �ʼ��÷�������� ����.
 *     - cfChangeCursor(theType) �Լ� �߰�
 *
 *     <font color="blue">V3.5</font>
 *     - cfBuildBodyTitle ����. ���� ������ Ŭ���� ����ȭ�鿡 �ش��ϴ� ������ ��쵵�� ��.
 *
 *     <font color="blue">V3.4</font>
 *     - cfDisable �Լ����� ��ư�� ���� disable�� �ι� �̻� ���� ����� ��ư �׸��� ������� ���׼���.
 *
 *     <font color="blue">V3.3</font>
 *     - cfDisable �ÿ� EMEdit�� Disable, input text�� ReadOnly���·� �ٲ�. ���õ� ���󺯰�.
 *     - cfDisable �ÿ� Grid ��ư�� Icon ��ư�� ���� Disable ǥ�� �߰�.
 *     - Grid Validation�ÿ� validFeatures �Ӽ� �߰�.
 *     - cfSortGrid �Լ� ���� ����.
 *     - validation �׸��߿��� number�� ���� decimal format �� ������ �� �ֵ��� ����߰�.
 *     - cfBuildTitle �Լ����� ȸ�� �׵θ������� ���� 800*600 ��忡�� ��ũ���� ����� ���� ����.
 *
 *     <font color="blue">V3.2</font>
 *     - Grid Validation�ÿ� singleKey �ɼ� �߰�.
 *     - Date.format���� mon, day format �ȵǴ� ���� ����.
 *     - �α��� ���� �Լ� ���� ����.
 *     - cfCopyRecord �Լ� �߰�
 *     - cfCopyDataSet �Լ���  resetStatus �ɼ� �߰�.
 *     - cfDeleteGridRows, cfUndoGridRows �Լ� ���� ����.
 *     - �б������׸� ���� validation üũ�ÿ� validation�� �������� ��� ������ ��Ŀ����
 *       ������ ���ؼ� ����� ��ũ��Ʈ ���� ����.
 *     - cfSortGrid �Լ� �Ķ���� ���� �� Sorting ��ȣǥ�� �߰�.
 *
 *     <font color="blue">V3.1</font>
 *     - �α��ΰ��� �Լ��߰�.
 *       cfGetLoginUserRoleCodeList(): ���� �α��� ������� �����ڵ帮��Ʈ(Array)�� ��ȯ�Ѵ�.
 *       cfGetLoginUserRoleNameList(): ���� �α��� ������� ��������Ʈ(Array)�� ��ȯ�Ѵ�.
 *       cfExistLoginUserRoleName()  : ���� �α��� ����ڿ���  �ش� �������� �ִ��� üũ �Ѵ�.
 *       cfExistLoginUserRoleCode()  : ���� �α��� ����ڿ���  �ش� �����ڵ尡 �ִ��� üũ �Ѵ�.
 *       cfGetLoginUserMPOIP ()      : ���� �α��� ������� ������ IP �� ��ȯ�Ѵ�.
 *       cfGetLoginUserRemoteAddr () : ���� �α��� ������� ���� IP �� ��ȯ�Ѵ�.
 *     - cfReset �Լ� ���� ����.
 *     - Date.format �޼ҵ忡�� mon, day pattern �߰�.
 *     - Grid Validation ����ÿ� MultiRowSelect �Ӽ��� false�� ��� error�� �߻��� Row��
 *       Mark�� ����� ���� �ʴ� ���� ����.
 *
 *     <font color="blue">V3.0</font>
 *     - �޷� ��ﶧ ������ ��/���� ���ʿ� �ߵ��� ����.
 *     - cfFillGridHeader ȣ��� DataSet�� DataId�� �������� �ʾ��� ��� ���� ����.
 *
 *     <font color="blue">V2.9</font>
 *     - �α��ΰ��� ���׼���.
 *     - Date.format �Լ����� AM/PM ���� ����.
 *
 *     <font color="blue">V2.8</font>
 *     - cfBuildBodyTitle �Լ����� �Ʒ��� ȸ���׵θ����� ��ġ�� 20px ���� �ű�. -> �˾�â ǥ�ؿ� ����
 *       �˾�â�� statusbar �� ������� �ǰ� �̿� ���� ������ �����Ͽ���.
 *
 *     <font color="blue">V2.7</font>
 *     - login�� ���õ� �Լ����� ���� �߰��Ǿ����ϴ�.
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
 *     - cfDigitalNumber ��������.
 *     - cfStyleGrid ���� features�� rowHeight �ɼ� �߰�.
 *     - ����޽��� ����.
 *     - cfStyleTreeView �Լ� �߰�.
 *
 *     <font color="blue">V2.6</font>
 *     - length �������� ������ �����Ͽ����ϴ�.
 *
 *     <font color="blue">V2.5</font>
 *     - Grid�� ���ǵ��� ���� �÷��� ���� validation ����� ������ �������� ���� ����.
 *     - Grid ǥ���Ŀ��� �÷�ǥ���� ���� valid expression �� ���� ��� ���� ":" �� ������ ������ üũ��
 *       ���� �ʾҴ� ���� ����.
 *     - Validation �޽��� ���� ����.
 *     - cfEnable, cfDisable, cfValidate �Լ� �Ķ���Ͱ� Single �� Array ���� ��� ȣȯ �����ϵ��� ����.
 *
 *     <font color="blue">V2.4</font>
 *     - Grid Validation ���� ����.
 *
 *     <font color="blue">V2.3</font>
 *     - ���� ��ǥ�� �޽��� ������å�� ���� ����޽��� ������Ʈ.
 *
 *     <font color="blue">V2.2</font>
 *     - Grid Validation ���� ����.
 *     - cfSavePageParameter �Լ� ���� ����.
 *     - Grid ������ ���� ���濡 ���� cfStyleGrid ���뺯��.
 *
 *     <font color="blue">V2.1</font>
 *     - format validation ���� �ѱۿ� ���� format ����.
 *     - Grid validation ���� Multi Key �� ���� validation ����.
 *     - cfShowCalendar �Լ� ����.
 *     - cfDisable �ÿ� textarea �� disabled ���� �ʴ� ���� ����.
 *     - filter �� ���õ� validation �׸��� filterIn �� filterOut���� ��������.
 *     - email validation �߰�.
 *     - cfDisable �Լ����� parent ������Ʈ�� ���� �ϰ� ���� ��� �߰�.
 *     - cfStyleGrid ���� suppress �÷��� ���� ���� ����.
 *     - cfIsNaviPage ���� ����.
 *     - cfFillGridNoDataMsg �Լ� ���� ����.
 *     - cfSavePageParameter �Լ� �߰�.
 *     - cfValidateMaxByteLength �Լ� ���� ����.
 *
 *     <font color="blue">V2.0</font>
 *     - cfStyleGrid ���� �÷��� ������ center�� ����.
 *     - maxLength validation ���� ���� �ذ�.
 *     - maxByteLength ������ �����޽��� ����.
 *
 *     <font color="blue">V1.9</font>
 *     - ����¡ ��� ���� �Լ� �߰�. (cfFillGridHeaderPeriod, cfGRadioChg, cfPrintPopupSetting)
 *     - onkeydown �̺�Ʈ���� cfValidateMaxByteLength �Լ� ȣ��� return���� ��������� �ʾƵ� ��.
 *     - cfIsIn �Լ� �߰�
 *     - MSG_CONFIRM_UPDATE --> MSG_NOTIFY_NOT_UPDATED �� ����.
 *     - ������ ��ȯ�ÿ� ��������� ������� �ʾ��� ��� confirm box ���� feature �߰�.
 *     - ���� �޽��� �߰�(MSG_CONFIRM_CONTINUE_WITHOUT_APPLY_CHANGE)
 *     - Grid Style ����� ���ɰ���. CrossTab, Suppress �ÿ��� ����ǵ��� ����.
 *     - String ��ü�� insert �޼ҵ� �߰�.
 *     - cfFillGridNoDataMsg �Լ��� �Ķ���� ���� �� Grid�� width�� style�� �������� ��� �߻��ϴ� ���� ����.
 *     - modal dialog box ���� ����¡�� ����� ��� ������ ��ũ Ŭ���� ��â�ߴ� ���� ����.
 *     - cfFillGridHeader �Լ� ����.
 *     - cfGetPageParameter �Լ� �߰�.
 *     - cfCopyDataSet �Լ� ����ÿ� target DataSet�� �Ӽ���(��, DataId)�� �������� ���� �ذ�.
 *
 *     <font color="blue">V1.8</font>
 *     - �˾�â���� ȭ��� ���� �� ���� �׸��� ������ ���� ����
 *
 *     <font color="blue">V1.7</font>
 *     - cfValidateMaxByteLength �Լ� �߰�.
 *
 *     <font color="blue">V1.6</font>
 *     - cfOpen �Լ� �߰�.
 *     - ��ȿ�� �˻��׸��߿��� byteLength, minByteLength, maxLength, maxByteLength �߰�.
 *     - Grid ��ȿ�� �˻�ÿ� key ���� ���� �ߺ�üũ �߰�. cfValidate �Լ� ����.
 *     - String.simpleReplace �Լ� �߰�.
 *     - String.trimAll �Լ� �߰�.
 *     - String.advancedSplit �Լ� �߰�.
 *     - String.ignoreSplit �Լ� ����.
 *     - cfGetCurrentDate �Լ�ȣ��� ������¥�� �Ѵ����� ��¥�� �������� ���� ����.
 *     - Grid�� ���� validation ������ ���� Grid�� validExp ���� ����� ��� item name�� ������� �ʾ��� ����
 *       �÷������� ��ü�ϵ��� ����.
 *     - Date.before �Լ� �߰�.
 *     - Date.after �Լ� �߰�.
 *     - cfNaviPageIn, cfNaviPageOut, cfIsNaviPage �Լ� �߰�. (������ cfNaviPageInto�� cfNaviPageLoad �Լ��� ������)
 *     - coParameterMap ������Ʈ �߰�.
 *
 *     <font color="blue">V1.5</font>
 *     - paging ���� Grid sorting�� �Ͼ ��� ���� ����.
 *     - ���ڰ��� ���� validation ���� ����.
 *     - cfCopyDataSet�� features �Ķ���� �߰�.
 *     - cfEnable �Լ� �߰�.
 *     - cfStyleGrid�� features �Ķ���� �߰�.
 *     - cfGetPageInfo �Լ� �߰�.
 *
 *     <font color="blue">V1.4</font>
 *     - filter ��ȿ�� �˻� �߰�.
 *     - String.ignoreSplit �Լ� �߰�.
 *
 *     <font color="blue">V1.3</font>
 *     - cfFillGridHeader ��� ���� �� �������̵���ư ����.
 *     - cfGetElementType �Լ� �߰�.
 *     - cfDisable �Լ� �߰�.
 *     - cfStyleTab �Լ� �߰�.
 *     - cfStyleGrid �Լ� �߰�.
 *     - cfFillGridNoDataMsg �Լ� �߰�.
 *     - cfGetCurrentDate �Լ� �߰�.
 *     - validation ���� �Լ� �� validation ����� ����.
 *     - cfIsNull �Լ� �߰�.
 *     - cfIsEnterKey �Լ� �߰�.
 *     - cfCopyDataSetHeader �Լ� �߰�.
 *     - cfCopyDataSet �Լ� �߰�.
 *
 *     <font color="blue">V1.2</font>
 *     - cfDelGridRows -> cfDeleteGridRows �� �Լ��� ����.
 *     - cfSelectAllGridRows �Լ� �߰�.
 *     - ����޼��� ����.
 *     - cfFillGridHeader �Ķ���� ����.
 *     - cfBuildBodyTitle �Լ� ����.
 *
 *     <font color="blue">V1.1</font>
 *     - cfDigitalNumber �Լ� �߰�.
 *     - cfNaviPageInto  �Լ� �߰�.
 *     - cfNaviPageLoad �Լ� �߰�.
 *     - cfBuildBodyTitle �Լ��� width �Ķ���� �߰�. ȭ�� ����� �°� ����ǥ���ϴ� �κ� �߰�. (���� ��������)
 * </pre>
 */

/** �� �κ��� document�� generate���� �ʽ��ϴ�.
 * @JScript �����ڷ�
 * - isNaN : ������ ��� ���ڷ� ����. - "001", "0", "", null
 * - substr(index[, length]) -> index���� ������ Ȥ�� length������ŭ.
 * - substring(start, end)  -> start index���� end index�������� string
 * Date ������Ʈ �����ڵ� - dateObj = new Date()
 *                        - dateObj = new Date(dateVal)
 *                        - dateObj = new Date(year, month, date[, hours[, minutes[, seconds[,ms]]]])
 */


//----------------------------- 1. ���� �޼��� �����Դϴ�. -------------------------------//
//------11�� 15�� ���� ���� �Ǹ� ���� �����ܶ��� ���ǵ� �޽��� ����� �̿��Ѵ�.----------------//

// common message
var MSG_SUCCESS_LOGIN = "@�� �ȳ��ϼ���?\n11��/15�� ���� �����˴ϴ�.\n'MSG_COM_INF_005'�� ����Ͽ� ����Ͽ� �ֽʽÿ�";
var MSG_CONFIRM_SAVE = "�����Ͻðڽ��ϱ�?\n11��/15�� ���� �����˴ϴ�.\n'MSG_COM_CRM_001'�� ����Ͽ� �ֽʽÿ�";
var MSG_COMPLETE_SAVE = "���������� �����Ͽ����ϴ�.\n11��/15�� ���� �����˴ϴ�.\n'MSG_COM_INF_001'�� ����Ͽ� �ֽʽÿ�";
var MSG_CONFIRM_REGIST = "����Ͻðڽ��ϱ�?\n11��/15�� ���� �����˴ϴ�.\n'MSG_COM_CRM_002�� ����Ͽ� �ֽʽÿ�";
var MSG_COMPLETE_REGIST = "���������� ����Ͽ����ϴ�.\n11��/15�� ���� �����˴ϴ�.\n'MSG_COM_INF_002'�� ����Ͽ� �ֽʽÿ�";
var MSG_CONFIRM_UPDATE = "�����Ͻðڽ��ϱ�?\n11��/15�� ���� �����˴ϴ�.\n'MSG_COM_CRM_003�� ����Ͽ� �ֽʽÿ�";
var MSG_COMPLETE_UPDATE = "���������� �����Ͽ����ϴ�.\n11��/15�� ���� �����˴ϴ�.\n'MSG_COM_INF_003'�� ����Ͽ� �ֽʽÿ�";
var MSG_CONFIRM_DELETE = "�����Ͻðڽ��ϱ�?\n11��/15�� ���� �����˴ϴ�.\n'MSG_COM_CRM_004�� ����Ͽ� �ֽʽÿ�";
var MSG_COMPLETE_DELETE = "���������� �����Ͽ����ϴ�.\n11��/15�� ���� �����˴ϴ�.\n'MSG_COM_INF_004'�� ����Ͽ� �ֽʽÿ�";
var MSG_NOTIFY_NOT_UPDATED = "����� ������ �����ϴ�.\n11��/15�� ���� �����˴ϴ�.\n'MSG_COM_ERR_001'�� ����Ͽ� �ֽʽÿ�";
var MSG_CONFIRM_CONTINUE_WITHOUT_APPLY_CHANGE = "��������� �ݿ����� �ʾҽ��ϴ�. ��� �Ͻðڽ��ϱ�?\n11��/15�� ���� �����˴ϴ�.\n'MSG_COM_CRM_005'�� ����Ͽ� ����Ͽ� �ֽʽÿ�";
var MSG_PARAM_TEST        = "���޵� 3���� �Ķ���ʹ� @, @, @ �Դϴ�.\n11��/15�� ���� �����˴ϴ�.\n'MSG_COM_INF_006'�� ����Ͽ� ����Ͽ� �ֽʽÿ�";

// validation message
var VMSG_VALID            = "��ȿ�մϴ�.\n11��/15�� ���� �����˴ϴ�.\n'MSG_COM_INF_007'�� ����Ͽ� ����Ͽ� �ֽʽÿ�";
var VMSG_ITEMNAME         = "@ ��(��) \n11��/15�� ���� �����˴ϴ�.\n'MSG_COM_ERR_030'�� ����Ͽ� ����Ͽ� �ֽʽÿ�";
var VMSG_GRID             = "@�� @��° �����Ϳ��� \n11��/15�� ���� �����˴ϴ�.\n'MSG_COM_ERR_031'�� ����Ͽ� ����Ͽ� �ֽʽÿ�";
var VMSG_ERR_DUPLICATE    = "�ߺ��� �� �����ϴ�.\n11��/15�� ���� �����˴ϴ�.\n'MSG_COM_ERR_032'�� ����Ͽ� ����Ͽ� �ֽʽÿ�";
var VMSG_ERR_LENGTH       = "@�ڸ�����ŭ �Է��Ͻʽÿ�.\n11��/15�� ���� �����˴ϴ�.\n'MSG_COM_ERR_005'�� ����Ͽ� �ֽʽÿ�";
var VMSG_ERR_BYTE_LENGTH  = "@�ڸ�����ŭ �Է��Ͻʽÿ�.(�ѱ��� @�ڸ���) \n11��/15�� ���� �����˴ϴ�.\n'MSG_COM_ERR_027'�� ����Ͽ� ����Ͽ� �ֽʽÿ�";
var VMSG_ERR_MIN_LENGTH   = "@�� �̻����� �Է��Ͻʽÿ�.\n11��/15�� ���� �����˴ϴ�.\n'MSG_COM_ERR_011'�� ����Ͽ� �ֽʽÿ�";
var VMSG_ERR_MIN_BYTE_LENGTH   = "@�� �̻����� �Է��Ͻʽÿ�. (�ѱ��� @�� �̻�)\n11��/15�� ���� �����˴ϴ�.\n'MSG_COM_ERR_028'�� ����Ͽ� ����Ͽ� �ֽʽÿ�";
var VMSG_ERR_MAX_LENGTH   = "@�� ���Ϸ� �Է��Ͻʽÿ�.\n11��/15�� ���� �����˴ϴ�.\n'MSG_COM_ERR_012'�� ����Ͽ� �ֽʽÿ�";
var VMSG_ERR_MAX_BYTE_LENGTH   = "@�� ���Ϸ� �Է��Ͻʽÿ�. (�ѱ��� @�� ����)\n11��/15�� ���� �����˴ϴ�.\n'MSG_COM_ERR_029'�� ����Ͽ� ����Ͽ� �ֽʽÿ�";
var VMSG_ERR_MIN_NUM      = "@ �̻����� �Է��Ͻʽÿ�.\n11��/15�� ���� �����˴ϴ�.\n'MSG_COM_ERR_013'�� ����Ͽ� �ֽʽÿ�";
var VMSG_ERR_MAX_NUM      = "@ ���Ϸ� �Է��Ͻʽÿ�.\n11��/15�� ���� �����˴ϴ�.\n'MSG_COM_ERR_014'�� ����Ͽ� �ֽʽÿ�";
var VMSG_ERR_IN_NUM       = "@���� @���̷� �Է��Ͻʽÿ�.\n11��/15�� ���� �����˴ϴ�.\n'MSG_COM_ERR_006'�� ����Ͽ� �ֽʽÿ�";
var VMSG_ERR_NUMBER       = "���ڸ��� �Է��Ͻʽÿ�.\n11��/15�� ���� �����˴ϴ�.\n'MSG_COM_ERR_007'�� ����Ͽ� �ֽʽÿ�";
var VMSG_ERR_ALPHA        = "���ڸ��� �Է��Ͻʽÿ�.\n11��/15�� ���� �����˴ϴ�.\n'MSG_COM_ERR_008'�� ����Ͽ� �ֽʽÿ�";
var VMSG_ERR_REQUIRED     = "�ʼ� �Է� �׸��Դϴ�.\n11��/15�� ���� �����˴ϴ�.\n'MSG_COM_ERR_002'�� ����Ͽ� �ֽʽÿ�";
var VMSG_ERR_SSN          = "��ȿ�� �ֹε�Ϲ�ȣ�� �ƴմϴ�.\n11��/15�� ���� �����˴ϴ�.\n'MSG_COM_ERR_016'�� ����Ͽ� �ֽʽÿ�";
var VMSG_ERR_CSN          = "��ȿ�� ����ڵ�Ϲ�ȣ�� �ƴմϴ�.\n11��/15�� ���� �����˴ϴ�.\n'MSG_COM_ERR_017'�� ����Ͽ� �ֽʽÿ�";
var VMSG_ERR_FILTER_IN    = "���� ���ڸ� �� �� �ֽ��ϴ�.\n@\n11��/15�� ���� �����˴ϴ�.\n'MSG_COM_ERR_036'�� ����Ͽ� ����Ͽ� �ֽʽÿ�";
var VMSG_ERR_FILTER_OUT   = "���� ���ڰ� �� �� �����ϴ�.\n@\n11��/15�� ���� �����˴ϴ�.\n'MSG_COM_ERR_033'�� ����Ͽ� ����Ͽ� �ֽʽÿ�";
var VMSG_ERR_DATE         = "��ȿ�� ��¥�� �ƴմϴ�.\n11��/15�� ���� �����˴ϴ�.\n'MSG_COM_ERR_018'�� ����Ͽ� �ֽʽÿ�";
var VMSG_ERR_EMAIL        = "��ȿ�� �̸��� �ּҰ� �ƴմϴ�.\n11��/15�� ���� �����˴ϴ�.\n'MSG_COM_ERR_037'�� ����Ͽ� ����Ͽ� �ֽʽÿ�";
var VMSG_ERR_YEAR         = "�⵵�� �߸��Ǿ����ϴ�.\n11��/15�� ���� �����˴ϴ�.\n'MSG_COM_ERR_015'�� ����Ͽ� �ֽʽÿ�";
var VMSG_ERR_MONTH        = "���� �߸��Ǿ����ϴ�.\n11��/15�� ���� �����˴ϴ�.\n'MSG_COM_ERR_019'�� ����Ͽ� �ֽʽÿ�";
var VMSG_ERR_DAY          = "���� �߸��Ǿ����ϴ�.\n11��/15�� ���� �����˴ϴ�.\n'MSG_COM_ERR_020'�� ����Ͽ� �ֽʽÿ�";
var VMSG_ERR_HOUR         = "�ð� �߸��Ǿ����ϴ�.\n11��/15�� ���� �����˴ϴ�.\n'MSG_COM_ERR_021'�� ����Ͽ� �ֽʽÿ�";
var VMSG_ERR_MINUTE       = "���� �߸��Ǿ����ϴ�.\n11��/15�� ���� �����˴ϴ�.\n'MSG_COM_ERR_022'�� ����Ͽ� �ֽʽÿ�";
var VMSG_ERR_SECOND       = "�ʰ� �߸��Ǿ����ϴ�.\n11��/15�� ���� �����˴ϴ�.\n'MSG_COM_ERR_023'�� ����Ͽ� �ֽʽÿ�";
var VMSG_ERR_MIN_DATE     = "@�� @�� @�� �����̾�� �մϴ�.\n11��/15�� ���� �����˴ϴ�.\n'MSG_COM_ERR_025'�� ����Ͽ� �ֽʽÿ�";
var VMSG_ERR_MAX_DATE     = "@�� @�� @�� �����̾�� �մϴ�.\n11��/15�� ���� �����˴ϴ�.\n'MSG_COM_ERR_024'�� ����Ͽ� �ֽʽÿ�";
var VMSG_ERR_FORMAT       = "'@' �����̾�� �մϴ�.\n" +
                            "  - # : ���� Ȥ�� ����\n" +
                            "  - h, H : �ѱ�(H�� ��������)\n" +
                            "  - A, Z : ����(Z�� ��������)\n" +
                            "  - 0, 9 : ����(9�� ��������)\n11��/15�� ���� �����˴ϴ�.\n'MSG_COM_ERR_026'�� ����Ͽ� �ֽʽÿ�";

var PMSG_ERR_PAGE         = "������ ������ �߸��Ǿ����ϴ�.\n11��/15�� ���� �����˴ϴ�.\n'MSG_COM_ERR_034'�� ����Ͽ� ����Ͽ� �ֽʽÿ�";
var PMSG_ERR_MAXPAGE      = "@������ �̻��� ����� �� �����ϴ�\n11��/15�� ���� �����˴ϴ�.\n'MSG_COM_ERR_035'�� ����Ͽ� �ֽʽÿ�";

//----------------------------- ���� ����Ǿ�� �� ���� �޽��� �����Դϴ�. ------------------------------//

var MSG_COM_INF_001   = "���������� �����Ͽ����ϴ�.";
var MSG_COM_INF_002   = "���������� ����Ͽ����ϴ�.";
var MSG_COM_INF_003   = "���������� �����Ͽ����ϴ�.";
var MSG_COM_INF_004   = "���������� �����Ͽ����ϴ�.";
var MSG_COM_INF_005   = "@�� �ȳ��ϼ���?";
var MSG_COM_INF_008   =  "�����ڿ��� �����Ͻʽÿ�.";
var MSG_COM_INF_009   =  "���������� ��µǾ����ϴ�.";
var MSG_COM_INF_010   =  "@��(��) ���������� �����Ͽ����ϴ�.";
var MSG_COM_INF_011   =  "@��(��) �����Ǿ����ϴ�.";
var MSG_COM_INF_012   =  "@��(��) ���������� �����Ͽ����ϴ�.";
var MSG_COM_INF_013   =  "ó���� ��ҵǾ����ϴ�.";
var MSG_COM_INF_007   =  "��ȿ�մϴ�.";
var MSG_COM_INF_015   =  "��ȿ�� @�Դϴ�.";
var MSG_COM_CRM_001   = "�����Ͻðڽ��ϱ�?";
var MSG_COM_CRM_002   = "����Ͻðڽ��ϱ�?";
var MSG_COM_CRM_003   = "�����Ͻðڽ��ϱ�?";
var MSG_COM_CRM_004   = "�����Ͻðڽ��ϱ�?";
var MSG_COM_CRM_005   = "��������� �ݿ����� �ʾҽ��ϴ�. ��� �Ͻðڽ��ϱ�?";
var MSG_COM_CRM_006   =  "�̹� �����ϴ� @ �Դϴ�. �߰��Ͻðڽ��ϱ�?";
var MSG_COM_CRM_008   =  "@��(��) �����Ͻðڽ��ϱ�?";
var MSG_COM_CRM_009   =  "@��(��) �����Ͻðڽ��ϱ�?";
var MSG_COM_CRM_010   =  "@��(��) �����Ͻðڽ��ϱ�?";
var MSG_COM_CRM_011   =  "����Ͻðڽ��ϱ�?";
var MSG_COM_CRM_013   =  "��� �����Ͻðڽ��ϱ�?";
var MSG_COM_ERR_001   = "@��(��) ����� ������ �����ϴ�.";
var MSG_COM_ERR_002   = "@��(��) �ʼ� �Է� �׸��Դϴ�.";
var MSG_COM_ERR_003   = "�ش�Ǵ� �ڷᰡ �������� �ʽ��ϴ�.";
var MSG_COM_ERR_004   = "@��(��) ������� �Է��Ͻʽÿ�.";
var MSG_COM_ERR_005   = "@��(��) @�ڸ�����ŭ �Է��Ͻʽÿ�.";
var MSG_COM_ERR_006   = "@��(��) @���� @���̷� �Է��Ͻʽÿ�.";
var MSG_COM_ERR_007   = "@��(��) ���ڸ��� �Է��Ͻʽÿ�.";
var MSG_COM_ERR_008   = "@��(��) ���ڸ��� �Է��Ͻʽÿ�.";
var MSG_COM_ERR_009   = "@��(��) ���ڿ� ���ڸ��� �Է��Ͻʽÿ�.(��������)";
var MSG_COM_ERR_010   = "@��(��) ���ڿ� ���ڸ��� �Է��Ͻʽÿ�.(��������)";
var MSG_COM_ERR_011   = "@��(��) @�� �̻����� �Է��Ͻʽÿ�.";
var MSG_COM_ERR_012   = "@��(��) @�� ���Ϸ� �Է��Ͻʽÿ�.";
var MSG_COM_ERR_013   = "@��(��) @ �̻����� �Է��Ͻʽÿ�.";
var MSG_COM_ERR_014   = "@��(��) @ ���Ϸ� �Է��Ͻʽÿ�.";
var MSG_COM_ERR_015   = "@��(��) �⵵�� �߸��Ǿ����ϴ�.";
var MSG_COM_ERR_016   = "@��(��) ��ȿ�� �ֹε�Ϲ�ȣ�� �ƴմϴ�.";
var MSG_COM_ERR_017   = "@��(��) ��ȿ�� ����ڵ�Ϲ�ȣ�� �ƴմϴ�.";
var MSG_COM_ERR_018   = "@��(��) ��ȿ�� ��¥�� �ƴմϴ�.";
var MSG_COM_ERR_019   = "@��(��) ���� �߸��Ǿ����ϴ�.";
var MSG_COM_ERR_020   = "@��(��) ���� �߸��Ǿ����ϴ�.";
var MSG_COM_ERR_021   = "@��(��) �ð� �߸��Ǿ����ϴ�.";
var MSG_COM_ERR_022   = "@��(��) ���� �߸��Ǿ����ϴ�.";
var MSG_COM_ERR_023   = "@��(��) �ʰ� �߸��Ǿ����ϴ�.";
var MSG_COM_ERR_025   = "@��(��) @�� @�� @�� �����̾�� �մϴ�.";
var MSG_COM_ERR_024   = "@��(��) @�� @�� @�� �����̾�� �մϴ�.";
var MSG_COM_ERR_026   = "@��(��) '@' �����̾�� �մϴ�.\n" +
                            "  - # : ���� Ȥ�� ����\n" +
                            "  - h, H : �ѱ�(H�� ��������)\n" +
                            "  - A, Z : ����(Z�� ��������)\n" +
                            "  - 0, 9 : ����(9�� ��������)";
var MSG_COM_ERR_027   =  "@��(��) @�ڸ�����ŭ �Է��Ͻʽÿ�. (�ѱ��� @�ڸ���)";
var MSG_COM_ERR_028   =  "@��(��) @�� �̻����� �Է��Ͻʽÿ�. (�ѱ��� @�� �̻�)";
var MSG_COM_ERR_029   =  "@��(��) @�� ���Ϸ� �Է��Ͻʽÿ�. (�ѱ��� @�� ����)";
var MSG_COM_ERR_030   =  "@��(��) ";
var MSG_COM_ERR_031   =  "@�� @��° �����Ϳ��� ";
var MSG_COM_ERR_032   =  "@��(��) �ߺ��� �� �����ϴ�.";
var MSG_COM_ERR_033   =  "@��(��) ���� ���ڰ� �� �� �����ϴ�.\n@";
var MSG_COM_ERR_034   =  "������ ������ �߸��Ǿ����ϴ�.";
var MSG_COM_ERR_035   =  "@������ �̻��� ����� �� �����ϴ�";
var MSG_COM_ERR_036   =  "@��(��) ���� ���ڸ� �� �� �ֽ��ϴ�.\n@";
var MSG_COM_ERR_037   =  "@��(��) ��ȿ�� �̸��� �ּҰ� �ƴմϴ�.";
var MSG_COM_ERR_038   =  "��ȿ�� @�� �ƴմϴ�."
var MSG_COM_ERR_039   =  "�������ڸ� �������� �������� ����[�Է�]�Ͽ� �ֽʽÿ�.";
var MSG_COM_ERR_040   =  "�н����尡 ��ġ���� �ʽ��ϴ�.";
var MSG_COM_ERR_041   =  "@��(��) @�� �� �����ϴ�.";
var MSG_COM_ERR_042   =  "@��(��) ����� ������ �ֽ��ϴ�. \n��������� ���� �� @��(��) �����Ͻʽÿ�.";
var MSG_COM_ERR_043	  =  "��ȿ���� �ʴ� @ �Դϴ�.\n�ٽ� �Է��Ͽ��ֽʽÿ�";
var MSG_COM_ERR_045   =  "���۹����� ����������� �۾ƾ� �մϴ�. :@";
var MSG_COM_ERR_046   =  "�������� �ʴ� @�Դϴ�.";
var MSG_COM_ERR_047   =  "������ �߻��Ͽ����ϴ�.\n�����ڿ��� �����Ͻʽÿ�.";
var MSG_COM_ERR_048   =  "@��(��) @���� �۾ƾ� �մϴ�.";
var MSG_COM_ERR_049   =  "@��(��) �������� �ʽ��ϴ�.";
var MSG_COM_ERR_050   =  "������ �߻��Ͽ����ϴ�.\nó������ �ٽ� �����Ͽ� �ֽʽÿ�.";
var MSG_COM_ERR_051   =  "@��(��) �����Ͽ����ϴ�.";
var MSG_COM_ERR_052   =  "�ش������� @��(��) �������� �ʽ��ϴ�.";
var MSG_COM_ERR_053   =  "@��(��) �����Ǿ����ϴ�.";
var MSG_COM_ERR_054   =  "@ ������ �����Ͽ����ϴ�.";
var MSG_COM_ERR_055   =  "@��(��) Ȯ���Ͽ� �ֽʽÿ�.";
var MSG_COM_ERR_056   =  "���õ� @��(��) �����ϴ�.";
var MSG_COM_ERR_057   =  "@��(��) @ ���� ū ������ �Է��Ͻʽÿ�.";
var MSG_COM_ERR_058   =  "���۽ð��� ����ð� �������� ����[�Է�]�Ͽ� �ֽʽÿ�.";
var MSG_COM_ERR_059   =  "@��(��) �����θ� @�� ���Ϸ� �Է��Ͻʽÿ�.";
var MSG_COM_ERR_060   =  "@��(��) �Ҽ��θ� @�� ���Ϸ� �Է��Ͻʽÿ�."
var MSG_COM_ERR_061   =  "�ش� �׸��� ���� ���� �մϴ�.\n�ٽ� Ȯ���Ͻð� �߰� �Ͻʽÿ�."
var MSG_COM_ERR_062   =  "@��(��) ��ȿ�� ���������ȣ�� �ƴմϴ�.\n ����Ͻðڽ��ϱ�?";
var MSG_COM_ERR_067   =  "@��(��) �ߺ��� ���������ȣ �Դϴ�.\n ����Ͻðڽ��ϱ�?";
var MSG_COM_ERR_063   =  "�����Ͽ����ϴ�."
var MSG_COM_ERR_064   =  "���������� ó���Ǿ����ϴ�."
var MSG_COM_ERR_065   =  "@��(��) ��ȿ�� �ֹε�Ϲ�ȣ�� �ƴմϴ�.\n ����Ͻðڽ��ϱ�?";
var MSG_COM_ERR_066   =  "@��(��) �ߺ��� �ֹε�Ϲ�ȣ �Դϴ�.\n ����Ͻðڽ��ϱ�?";
var MSG_COM_WRN_001   =  "������ �����Ͱ� �������� �ʽ��ϴ�.\n���� @�˻��� �Ͻʽÿ�.";
var MSG_COM_WRN_002   =  "��ȸ����� �������� �ʽ��ϴ�.";
var MSG_COM_WRN_003   =  "@��(��) �Է��Ͻʽÿ�.";
var MSG_COM_WRN_004   =  "������ @��(��) �������� �ʽ��ϴ�.";
var MSG_COM_WRN_005   =  "'+' ��ư�� ���� �� �Է��Ͻʽÿ�.";
var MSG_COM_WRN_006   =  "'+'��ư�� ������ �� @��(��) �Է��Ͻʽÿ�.";
var MSG_COM_WRN_007   =  "@��(��) �����Ͻʽÿ�.";
var MSG_COM_WRN_008   =  "�˻��� �����Ͱ� �������� �ʽ��ϴ�.\n���� @�˻��� �Ͻʽÿ�.";
var MSG_COM_WRN_009   =  "����� @��(��) �����ϴ�.";
var MSG_COM_WRN_010   =  "@ ��ư�� �̿��Ͻʽÿ�.";
var MSG_COM_WRN_011   =  "�̹� �����ϴ� @�Դϴ�.";
var MSG_COM_WRN_012   =  "@��(��) �ݿ����� �ʾҽ��ϴ�.";
var MSG_COM_WRN_013	= "@ ��(��) @��(��) �����ϴ�.";
var HR_WARNING_01	=  "�⺻������ �Էµ��� �ʾҽ��ϴ�.\n���� �⺻������ �Է��� �ּ���";
var HR_WARNING_02	=  "@��(��) '@' �����̾�� �մϴ�.\n'@'";
var HR_WARNING_03	=  "@ ��ư�� ������ ������ �ּ���";
var HR_WARNING_04	=  MSG_COM_ERR_002 + " @��° "+MSG_COM_WRN_003;
var HR_WARNING_05	= "@�⵵ @ȸ���� @��(��) �̹� ��ϵǾ� �ֽ��ϴ�.";
var HR_WARNING_06	= "�˻������ �����ϴ�.";
var HR_WARNING_07	= "@" +  MSG_COM_CRM_001;
var HR_WARNING_08	= "@�� �Էµ��� �ʾҽ��ϴ�.�⺻�������� �Է��Ͻðڽ��ϱ�?";
var HR_WARNING_09	= "'@' �� ������ �����Ͱ� �����մϴ�. ����Ͻðڽ��ϱ�?";
var HR_WARNING_10	= "'@'�� �����Ͱ� ���������� ó���Ǿ����ϴ�.";
var HR_WARNING_11	= "'@' ��°�� ������ �����Ͱ� �����մϴ�.";
var HR_WARNING_12	= "'@' �� �������� �ʴ� �ֹε�Ϲ�ȣ�Դϴ�.";
var HR_WARNING_13	=	"@ ��	@(��)�� �Ⱓ�� ��Ȯ���� �ʽ��ϴ�.";
var HR_WARNING_14	=	"���� �����͸� �Է��� ����� ��ȸ�Ͻʽÿ�";
var HR_WARNING_15	=	"����� ������ �����ϴ�.";

var MSG_COM_GAUCE_50000 	 = 		 "�����Ͽ����ϴ�.";
var MSG_COM_GAUCE_50001    =     "�����Ͽ����ϴ�.";
var MSG_COM_GAUCE_50002    =     "�ش� property���� ��ȿ���� �ʽ��ϴ�. (property��:CodeColumn )	";
var MSG_COM_GAUCE_50003    =     "�ش� property���� ��ȿ���� �ʽ��ϴ�. (property��:DataColumn )	";
var MSG_COM_GAUCE_50004    =     "Combo Dataset���� column �� ã�� ���߽��ϴ�.	";
var MSG_COM_GAUCE_50005    =     "�ش� property���� ��ȿ���� �ʽ��ϴ�. (property��:CodeCColumn )	";
var MSG_COM_GAUCE_50006    =     "�ش� property���� ��ȿ���� �ʽ��ϴ�. (property��:DataCColumn )	";
var MSG_COM_GAUCE_50009    =     "�ش� Code value���� setting�� �����Ͽ����ϴ�.	";
var MSG_COM_GAUCE_50010    =     "�ش� Data value���� setting�� �����Ͽ����ϴ�.	";
var MSG_COM_GAUCE_50007		 =	 	 "�ش� property���� ��ȿ���� �ʽ��ϴ�. (property��:DataID )	";
var MSG_COM_GAUCE_50008    =     "�ش� property���� ��ȿ���� �ʽ��ϴ�. (property��:ComboDataID )	";
var MSG_COM_GAUCE_50007    =     "�ش� property���� ��ȿ���� �ʽ��ϴ�. ";
var MSG_COM_GAUCE_50062    =     "�ش� property���� ��ȿ���� �ʽ��ϴ�. (property��:xValueColumn )	";
var MSG_COM_GAUCE_50063    =     "�ش� property���� ��ȿ���� �ʽ��ϴ�. (property��:yValueColumns )	";
var MSG_COM_GAUCE_50011    =     "Data�� ��µ� �����Ͽ����ϴ�.	";
var MSG_COM_GAUCE_50012    =     "����Ÿ �ٿ�ε��� ������ �߻��Ͽ����ϴ�.	";
var MSG_COM_GAUCE_50013    =     "�ڿ��� �����Ͽ� ó���Ҽ� �����ϴ�. �ٸ� ���� ���α׷��� ������ �ٽ� �õ��� ���ʽÿ�.	";
var MSG_COM_GAUCE_50014    =     "����Ÿ �ε��� ���信 ������ �ֽ��ϴ�.	";
var MSG_COM_GAUCE_50015    =     "�������� ������ ���� �޼����� ���۵Ǿ����ϴ�.	";
var MSG_COM_GAUCE_50016    =     "����Ÿ�� ���� ����� ���������� �ٸ��ϴ�.	";
var MSG_COM_GAUCE_50017    =     "����Ÿ �ε��� ������ ���� ������ �߻��Ǿ����ϴ�.	";
var MSG_COM_GAUCE_50018    =     "�� �÷��� NULL���� ������ �����ϴ�.	";
var MSG_COM_GAUCE_50019    =     "key column���� ������ �÷��� �ٸ�row�� ���� ���� ���� ���մϴ�. �ٸ� ���� ������ �ֽʽÿ�.";
var MSG_COM_GAUCE_50020    =     "filter�� row���� �� key column���� ������ �÷��� �ٸ� row�� ���� ���� ���� ���մϴ�. �ٸ� ���� ������ �ֽʽÿ�.	";
var MSG_COM_GAUCE_50021    =     "������ dataset�� ���°� �б� �����Դϴ�..const column ���� �����ų�� �����ϴ�.	";
var MSG_COM_GAUCE_50022    =     "�Էµ� column index�� ��ü column ���� ������ ������ϴ�. const column ���� �����ų�� �����ϴ�.	";
var MSG_COM_GAUCE_50023    =     "const column ���� �����ų �� �����ϴ�.	";
var MSG_COM_GAUCE_50023    =     "const column ���� �����ų �� �����ϴ�.	";
var MSG_COM_GAUCE_50023    =     "const column ���� �����ų �� �����ϴ�.	";
var MSG_COM_GAUCE_50024    =     "������ dataset �� ���°� �б� �����Դϴ�. column ���� �����ų�� �����ϴ�.	";
var MSG_COM_GAUCE_50025    =     "�Էµ� Row Index�� ��ü Row ���� ������ ������ϴ�.  column ���� �����ų�� �����ϴ�.	";
var MSG_COM_GAUCE_50026    =     "�Էµ� column index�� ��ü column ���� ������ ������ϴ�.  column ���� �����ų�� �����ϴ�.";
var MSG_COM_GAUCE_50027    =     "�� �÷��� ����÷��� �ƴմϴ�.  �ش� Method of Property�� ����Ҽ� �����ϴ�. 	";
var MSG_COM_GAUCE_50028    =     "update��忡���� key column�� �����Ҽ� �����ϴ�.  column ���� �����ų�� �����ϴ�.	";
var MSG_COM_GAUCE_50029    =     "column ���� �����ų �� �����ϴ�.	";
var MSG_COM_GAUCE_50030    =     "�ش��ϴ� ColumnID�� ã�� �� �����ϴ�.  ��Ȯ�� ColumnID���� Ȯ���Ͻʽÿ�.	";
var MSG_COM_GAUCE_50031    =     "������ ������ ������ �ֽ��ϴ�.. 	";
var MSG_COM_GAUCE_50032    =     "report format property���� ������ �ֽ��ϴ�.   Format���� Ȯ�� �غ��ñ� �ٶ��ϴ�.	";
var MSG_COM_GAUCE_50033    =     "Suppress Column string���� �ش� column�� ã���� �����ϴ�.	";
var MSG_COM_GAUCE_50064    =     "�ش� property���� ��ȿ���� �ʽ��ϴ�. (property��:Format )	";
var MSG_COM_GAUCE_50034    =     "Report Format Property���� ����� tag�� ������� �ʾҽ��ϴ�.	";
var MSG_COM_GAUCE_50035    =     "Report Format Property���� tag�� ¦�� ���� �ʽ��ϴ�.	";
var MSG_COM_GAUCE_50036    =     "Format script�� ������ ������ ���� ������ �ֽ��ϴ�.  script�� Ȯ���� ���ʽÿ�.	";
var MSG_COM_GAUCE_50037    =     "div tag�� ã�µ� �����Ͽ����ϴ�.	";
var MSG_COM_GAUCE_50038    =     "Server IP property���� �Էµ��� �ʾҽ��ϴ�.	";
var MSG_COM_GAUCE_50039    =     "Action property���� �Էµ��� �ʾҽ��ϴ�.	";
var MSG_COM_GAUCE_50040    =     "KeyName property���� �Էµ��� �ʾҽ��ϴ�.	";
var MSG_COM_GAUCE_50041    =     "KeyValue property���� �Էµ��� �ʾҽ��ϴ�.";
var MSG_COM_GAUCE_50042    =     "KeyValue property format���� ������ �ֽ��ϴ�.	";
var MSG_COM_GAUCE_50043    =     "WinInet API ����.	";
var MSG_COM_GAUCE_50044    =     "IDispatch ȣ�⿡�� �ý��ۿ����� �߻��Ͽ����ϴ�.	";
var MSG_COM_GAUCE_50045    =     "Server���� �����޼����� ������ ���� �����Խ��ϴ�.	";
var MSG_COM_GAUCE_50046    =     "������ �ڵ鿡 ������ �ֽ��ϴ�.	";
var MSG_COM_GAUCE_50047    =     "Font������ ��µ� �����Ͽ����ϴ�.	";
var MSG_COM_GAUCE_50048    =     "Background Color������ ��µ� �����Ͽ����ϴ�.	";
var MSG_COM_GAUCE_50049    =     "COLOR ������ ��µ� �����Ͽ����ϴ�.	";
var MSG_COM_GAUCE_50050    =     "Image List ����µ� �����Ͽ����ϴ�.	";
var MSG_COM_GAUCE_50051    =     "DataSet�� Data�� �� ���� ������ ��µ� �����Ͽ����ϴ�.	";
var MSG_COM_GAUCE_50052    =     "����� �ڷᰡ �����ϴ�.	";
var MSG_COM_GAUCE_50053    =     "DataColumn Property���� �Էµ��� �ʾҽ��ϴ�.	";
var MSG_COM_GAUCE_50054    =     "CodeColumn Property���� �Էµ��� �ʾҽ��ϴ�.	";
var MSG_COM_GAUCE_50065    =     "����Ÿ���۸� �Ҵ��ϴµ� �����Ͽ����ϴ�.	";
var MSG_COM_GAUCE_50055    =     "��ο� ������ �߻��߽��ϴ�.	";
var MSG_COM_GAUCE_50056    =     "���������� ����Ǿ����ϴ�.	";
var MSG_COM_GAUCE_50057    =     "page Size�� ��µ� ��band���� ���� �۽��ϴ�.	";
var MSG_COM_GAUCE_50058    =     "Index�� ������ �ʰ��Ͽ����ϴ�.	";
var MSG_COM_GAUCE_50059    =     "DataRColumn Property���� �Էµ��� �ʾҽ��ϴ�.	";
var MSG_COM_GAUCE_50060    =     "CodeRColumn Property���� �Էµ��� �ʾҽ��ϴ�.	";
var MSG_COM_GAUCE_50062    =     "�ش� property���� ��ȿ���� �ʽ��ϴ�. (property��:RadioDataID )	";
var MSG_COM_GAUCE_50061    =     "LZW type�� �̹����� �������� �ʽ��ϴ�.	";
var MSG_COM_GAUCE_50073    =     "���� �ð��� �ʰ��Ǿ����ϴ�.	";
var MSG_COM_GAUCE_50070    =     "�߸��� �̹��� URL�Դϴ�.";
var MSG_COM_GAUCE_50071    =     "�̹��� �޸� ���� �ε忡 �����Ͽ����ϴ�.";
var MSG_COM_GAUCE_50072    =     "Lead PaintDC�� �����µ� �����Ͽ����ϴ�.";
var MSG_COM_GAUCE_501      =     "�߶󳻱�\tCtrl+X";
var MSG_COM_GAUCE_502      =     "�����ϱ�\tCtrl+C";
var MSG_COM_GAUCE_503      =     "�ٿ��ֱ�\tCtrl+V";
var MSG_COM_GAUCE_504      =     "�����ϱ�\tDel";
var MSG_COM_GAUCE_50069    =     "��μ���\tCtrl+A";
var MSG_COM_GAUCE_901      =     "�� ";
var MSG_COM_GAUCE_902      =     "�հ� ";
var MSG_COM_GAUCE_903      =     "����ü";
var MSG_COM_GAUCE_601      =     "��� .......";
var MSG_COM_GAUCE_602      =     "���� �̹�����(%d).....";
var MSG_COM_GAUCE_606      =     "�̹��� �޴���.....";
var MSG_COM_GAUCE_608      =     "����� .....";
var MSG_COM_GAUCE_603      =     "�� ������ :";
var MSG_COM_GAUCE_604      =     "��¼���";
var MSG_COM_GAUCE_605      =     "���";
var MSG_COM_GAUCE_607      =     "����";
var MSG_COM_GAUCE_701      =     "�����͸� �ʱ�ȭ �� �� �����ϴ�.";
var MSG_COM_GAUCE_702      =     "�������� �μ��� �� �����ϴ�.";
var MSG_COM_GAUCE_609      =     "�μ� �۾��� ������ �� �����ϴ�.";
var MSG_COM_GAUCE_50067    =     "�ش� property���� ��ȿ���� �ʽ��ϴ�. (property��:ImgDColumn )	";
var MSG_COM_GAUCE_50066    =     "�ش� property���� ��ȿ���� �ʽ��ϴ�. (property��:ImgCColumn )	";
var MSG_COM_GAUCE_50068    =     "�ش� property���� ��ȿ���� �ʽ��ϴ�. (property��:ImgOColumn )	";
var MSG_COM_GAUCE_51000    =     "Tr�� Post �޼ҵ忡�� ����Ű ������ �����߽��ϴ�.";
var MSG_COM_GAUCE_51010    =     "Tr�� Parameters�Ӽ����� ��ȣȭ�ϴµ� �����߽��ϴ�.";
var MSG_COM_GAUCE_52000    =     "SeriesType�� ���� �ʽ��ϴ�.";
var MSG_COM_GAUCE_52001    =     "�������� �ʴ� Category�ų� Property�Դϴ�.";
var MSG_COM_GAUCE_50074    =     "����� ���� �����ڵ�� NULL�� �ɼ� �����ϴ�.";
var MSG_COM_GAUCE_53900    =     "��Ŷ�� Magic ID�� �����ϴ�.";
var MSG_COM_GAUCE_53903    =     "��Ŷ ������� Magic ID�� Ȯ���� �� �����ϴ�.";
var MSG_COM_GAUCE_53905    =     "��Ŷ�� Magic ���ڿ��� �����ϴ�.";
var MSG_COM_GAUCE_53906    =     "��Ŷ ������� Format Type�� Ȯ���� �� �����ϴ�.";
var MSG_COM_GAUCE_53910    =     "��Ŷ ������� Data Size�� Ȯ���� �� �����ϴ�..";
var MSG_COM_GAUCE_53911    =     "��Ŷ���� �����͸� ���� �� �����ϴ�.";
var MSG_COM_GAUCE_53990    =     "��Ʈ�� ��Ŷ�� ���� ������ �ֽ��ϴ�.";
var MSG_COM_GAUCE_53991    =     "���� ��Ŷ�� ���� ������ �ֽ��ϴ�.";
var MSG_COM_GAUCE_53930    =     "��Ʈ�� ��Ŷ�� ã�� �� �����ϴ�.";
var MSG_COM_GAUCE_53950    =     "�������� ������ �����͸� ������ �����ͼ��� ã�� �� �����ϴ�.";
var MSG_COM_GAUCE_53951    =     "Ŭ���̾�Ʈ���� ����ϴ� �����ͼ� ����Ʈ�� �������� ������ �����ͼ� ����Ʈ�� �ٸ��ϴ�.";
var MSG_COM_GAUCE_53952    =     "����� �����͸� Ǯ�� ���߽��ϴ�.";
var MSG_COM_GAUCE_53992    =     "���� ���� �޽����� ó������ ���߽��ϴ�.";

//----------------------------- 2. ���� ��ũ��Ʈ �����Դϴ�. -----------------------------//
// Global ��������
var GLB_MONTH_IN_YEAR       = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
var GLB_SHORT_MONTH_IN_YEAR = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
var GLB_DAY_IN_WEEK         = ["Sunday", "Monday", "Tuesday", "Wednesday","Thursday", "Friday", "Saturday"];
var GLB_SHORT_DAY_IN_WEEK   = ["Sun", "Mon", "Tue", "Wed","Thu", "Fri", "Sat"];
var GLB_DAYS_IN_MONTH       = [31,28,31,30,31,30,31,31,30,31,30,31];

var GLB_URL_COMMON_PAGE     = "";  // common ���丮�� URL ( ���� PATH ROOT )

  if ( checkServerDomain() ) {
   GLB_URL_COMMON_PAGE= "./common/"; // ���� ��ü ����� �϶�
  } else {
   //GLB_URL_COMMON_PAGE= "c:/eKPLS/common/"; //  �κ��� ��� �϶�
   GLB_URL_COMMON_PAGE= "G:/hun122_Template/0001/common/"; //  �κ��� ��� �϶�
  }

var GLB_REPORT_MAXPAGE      = 100000000;  // ��°����� �ִ� ������ ��
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
 * @desc   : �ڹٽ�ũ��Ʈ�� ���� ��ü�� String ��ü�� simpleReplace �޼ҵ带 �߰��Ѵ�. simpleReplace �޼ҵ��
 *           ��Ʈ�� ���� �ִ� Ư�� ��Ʈ���� �ٸ� ��Ʈ������ ��� ��ȯ�Ѵ�. String ��ü�� replace �޼ҵ�� ������
 *           ����� ������ ������ ��Ʈ���� ġȯ�ÿ� ���� �����ϰ� ����� �� �ִ�.
 * <pre>
 *     var str = "abcde"
 *     str = str.simpleReplace("cd", "xx");
 * </pre>
 * ���� ������ str�� "abxxe"�� �ȴ�.
 * @sig    : oldStr, newStr
 * @param  : oldStr required �ٲ��� �� ������ ��Ʈ��
 * @param  : newStr required �ٲ���� ���ο� ��Ʈ��
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
 * @desc   : �ڹٽ�ũ��Ʈ�� ���� ��ü�� String ��ü�� trim �޼ҵ带 �߰��Ѵ�. trim �޼ҵ�� ��Ʈ���� �հ� �ڿ�
 *           �ִ� white space �� �����Ѵ�.
 * <pre>
 *     var str = " abcde "
 *     str = str.trim();
 * </pre>
 * ���� ������ str�� "abede"�� �ȴ�.
 * @return : trimed String.
 * @author : GAUCE
 */
String.prototype.trim = function() {
    return this.replace(/(^\s*)|(\s*$)/g, "");
}

/**
 * @type   : prototype_function
* @access : public
 * @desc   : �ڹٽ�ũ��Ʈ�� ���� ��ü�� String ��ü�� trimAll �޼ҵ带 �߰��Ѵ�. trim �޼ҵ�� ��Ʈ�� ����
 *           �ִ� white space �� ��� �����Ѵ�.
 * <pre>
 *     var str = " abc de "
 *     str = str.trimAll();
 * </pre>
 * ���� ������ str�� "abcde"�� �ȴ�.
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
 * @desc   : �ڹٽ�ũ��Ʈ�� ���� ��ü�� String ��ü�� cut �޼ҵ带 �߰��Ѵ�. cut �޼ҵ�� ��Ʈ���� Ư�� ������
 *           �߶󳽴�.
 * <pre>
 *     var str = "abcde"
 *     str = str.cut(2, 2);
 * </pre>
 * ���� ������ str�� "abe"�� �ȴ�.
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
 * @desc   : �ڹٽ�ũ��Ʈ�� ���� ��ü�� String ��ü�� insert �޼ҵ带 �߰��Ѵ�. insert �޼ҵ�� ��Ʈ���� Ư�� ������
 *           �־��� ��Ʈ���� �����Ѵ�.
 * <pre>
 *     var str = "abcde"
 *     str = str.insert(3, "xyz");
 * </pre>
 * ���� ������ str�� "abcxyzde"�� �ȴ�.
 * @sig    : start, length
 * @param  : index required ������ ��ġ. �ش� ��Ʈ���� index �ٷ� �տ� ���Եȴ�. index�� 0���� ����.
 * @param  : str   required ������ ��Ʈ��.
 * @return : inserted String.
 * @author : GAUCE
 */
String.prototype.insert = function(index, str) {
    return this.substring(0, index) + str + this.substr(index);
}

/**
 * @type   : prototype_function
 * @access : public
 * @desc   : String.split() �� ������ �������� �ɼ��� �� �� �ִ�.
 * <pre>
 *     option list
 *
 *     - i : ignored split
 *         ������ ���� �տ� "\" �� �پ����� ���� �����ڷ� �ν����� �ʴ´�. ('\' ���ڸ� string���� ǥ���� ���� "\\" �� �ؾ���)
 *             var str = "abc,de\\,fg"
 *             var strArr = str.advancedSplit(",", "i");
 *         ���� ������ strArr[0]�� "abc", strArr[1]�� "de,fg"�� �ȴ�.
 *
 *     - t : trimed split
 *         split �Ŀ� splited string ���� trim ��Ų��.
 *             var str = "abc,  de,fg"
 *             var strArr = str.advancedSplit(",", "t");
 *         ���� ������ strArr[0]�� "abc", strArr[1]�� "de", strArr[2]�� "fg"�� �ȴ�.
 * </pre>
 * �ɼǵ��� ���������� ���� �� �ִ�.
 * <pre>
 *     var str = "abc,  de\\,fg"
 *     var strArr = str.advancedSplit(",", "it");
 * </pre>
 * ���� ������ strArr[0]�� "abc", strArr[1]�� "de,fg"�� �ȴ�.
 * @sig    : delim, options
 * @param  : delim   required delimenator
 * @param  : options required �ɼ��� ��Ÿ���� ���ڵ��� ������ ��Ʈ��
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
 * @desc   : �ڹٽ�ũ��Ʈ�� ���� ��ü�� String ��ü�� toDate �޼ҵ带 �߰��Ѵ�. toDate �޼ҵ�� ��¥�� ǥ���ϴ�
 *           ��Ʈ�� ���� �ڹٽ�ũ��Ʈ�� ���� ��ü�� Date ��ü�� ��ȯ�Ѵ�.
 * <pre>
 *     var date = "2002-03-05".toDate("YYYY-MM-DD")
 * </pre>
 * ���� ������ date ������ ������ 2002�� 3�� 5���� ǥ���ϴ� Date ������Ʈ�� ����Ų��.
 * @sig    : [pattern]
 * @param  : pattern optional Date�� ǥ���ϰ� �ִ� ������ String�� pattern���� ǥ���Ѵ�. (default : YYYYMMDD)
 * <pre>
 *     # syntex
 *
 *       YYYY : year(4�ڸ�)
 *       YY   : year(2�ڸ�)
 *       MM   : month in year(number)
 *       DD   : day in month
 *       HH   : hour in day (0~23)
 *       mm   : minute in hour
 *       ss   : second in minute
 *       SS   : millisecond in second
 *
 *     <font color=red>����)</font> YYYY(YY)�� �ݵ�� �־�� �Ѵ�. YYYY(YY) �� ����� ���� 1�� 1���� ��������
 *     �ϰ� YYYY�� MM ������� ���� 1���� �������� �Ѵ�.
 * </pre>
 * @return : ��ȯ�� Date Object.
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
 * @desc   : �ڹٽ�ũ��Ʈ�� ���� ��ü�� Date ��ü�� format �޼ҵ带 �߰��Ѵ�. format �޼ҵ�� Date ��ü�� ���� ��¥��
 *           ������ ������ ��Ʈ������ ��ȯ�Ѵ�.
 * <pre>
 *     var dateStr = new Date().format("YYYYMMDD");
 *
 *     ���� : Date ������Ʈ �����ڵ� - dateObj = new Date()
 *                                   - dateObj = new Date(dateVal)
 *                                   - dateObj = new Date(year, month, date[, hours[, minutes[, seconds[,ms]]]])
 * </pre>
 * ���� ������ ���ó�¥�� 2002�� 3�� 5���̶�� dateStr�� ���� "20020305"�� �ȴ�.
 * default pattern�� "YYYYMMDD"�̴�.
 * @sig    : [pattern]
 * @param  : pattern optional ��ȯ�ϰ��� �ϴ� ���� ��Ʈ��. (default : YYYYMMDD)
 * <pre>
 *     # syntex
 *
 *       YYYY : hour in am/pm (1~12)
 *       MM   : month in year(number)
 *       MON  : month in year(text)  ��) "January"
 *       mon  : short month in year(text)  ��) "Jan"
 *       DD   : day in month
 *       DAY  : day in week  ��) "Sunday"
 *       day  : short day in week  ��) "Sun"
 *       hh   : hour in am/pm (1~12)
 *       HH   : hour in day (0~23)
 *       mm   : minute in hour
 *       ss   : second in minute
 *       SS   : millisecond in second
 *       a    : am/pm  ��) "AM"
 * </pre>
 * @return : Date�� ǥ���ϴ� ��ȯ�� String.
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
 * @desc   : ���� Date ��ü�� ��¥���� ���ĳ�¥�� ���� Date ��ü�� �����Ѵ�.
 *           ���� ��� ���� ��¥�� �������� ������ ���� �ϸ� �ȴ�.
 * <pre>
 *     var oneDayAfter = new Date.after(0, 0, 1);
 * </pre>
 * @sig    : [years[, months[, dates[, hours[, minutes[, seconds[, mss]]]]]]]
 * @param  : years   optional ���� ���
 * @param  : months  optional ���� ����
 * @param  : dates   optional ���� �ϼ�
 * @param  : hours   optional ���� �ð���
 * @param  : minutes optional ���� �м�
 * @param  : seconds optional ���� �ʼ�
 * @param  : mss     optional ���� �и��ʼ�
 * @return : ���ĳ�¥�� ǥ���ϴ� Date ��ü
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
 * @desc   : ���� Date ��ü�� ��¥���� ������¥�� ���� Date ��ü�� �����Ѵ�.
 *           ���� ��� ���� ��¥�� �������� ������ ���� �ϸ� �ȴ�.
 * <pre>
 *     var oneDayBefore = new Date.before(0, 0, 1);
 * </pre>
 * @sig    : [years[, months[, dates[, hours[, minutes[, seconds[, mss]]]]]]]
 * @param  : years   optional �������� ���ư� ���
 * @param  : months  optional �������� ���ư� ����
 * @param  : dates   optional �������� ���ư� �ϼ�
 * @param  : hours   optional �������� ���ư� �ð���
 * @param  : minutes optional �������� ���ư� �м�
 * @param  : seconds optional �������� ���ư� �ʼ�
 * @param  : mss     optional �������� ���ư� �и��ʼ�
 * @return : ������¥�� ǥ���ϴ� Date ��ü
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
 * @desc   : ����޼����� ���ǵ� �޼����� alert box�� ������ �� �����Ѵ�. cfGetMsg ����.
 * @sig    : msgId[, paramArray]
 * @param  : msgId required common.js�� ���� �޼��� ������ ����� �޼��� ID
 * @param  : paramArray optional �޼������� '@' ���ڿ� ġȯ�� ������ Array. Array�� index�� �޼��� ���� '@' ������ ������ ��ġ�Ѵ�.
             ġȯ�� �����ʹ� [] ���̿� �޸��� �����ڷ� �Ͽ� ����ϸ� Array �� �νĵȴ�.
 * @return : ġȯ�� �޼��� ��Ʈ��
 * @author : GAUCE
 */
function cfAlertMsg(msgId, paramArray) {
	if (cfIsNull(msgId)) {
		alert("�������� �ʴ� �޽����Դϴ�.");
		return null;
	}

	var msg = new coMessage().getMsg(msgId, paramArray);
	alert(msg);
	return msg;
}

/**
 * @type   : function
 * @access : public
 * @desc   : �ʵ忡 �ִ� �ڸ����� �Է��� �� ������ �ٸ� �ʵ�� ��Ŀ���� �ڵ����� �̵��ȴ�.<br>
 *           html�� <Input type="text"> �� ���콺 EMEdit���� ��밡���ϴ�. <Input type="text"> �� ���
 *           maxLength �Ӽ��� �����Ǿ� �־�� �ϸ� EMEdit�� ��� MaxLength�� Format �Ӽ��� �ϳ��� �ݵ��
 *           ����Ǿ�� �Ѵ�.<br>
 *           byte length(�ѱ�)�� �������� �ʴ´�.<br>
 *           ������Ʈ ����� onkeydown �̺�Ʈ�� ������ ���� ����� �־�߸� �Ѵ�.
 * <pre>
 *     �ֹι�ȣ
 *     &lt;input id="oSsn1" type="text" size="6" maxLength="6" onkeydown="cfAutoFocusNext(this, oSsn2)"&gt;-
 *     &lt;input id="oSsn2" type="text" size="7" maxLength="7"&gt;
 * </pre>
 * @sig    : oElement, oNextElement
 * @param  : oElement required ���� �Է��ʵ�
 * @param  : oNextElement required �ڵ����� ��Ŀ���� �̵��� �ʵ�
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
 * @desc   : �ʵ忡 �ִ� �ڸ����� �Է��� �� ������ �ٸ� �ʵ�� ��Ŀ���� �ڵ����� �̵��ȴ�.<br>
 *           html�� <Input type="text"> �� ���콺 EMEdit���� ��밡���ϴ�. <Input type="text"> �� ���
 *           maxLength �Ӽ��� �����Ǿ� �־�� �ϸ� EMEdit�� ��� MaxLength�� Format �Ӽ��� �ϳ��� �ݵ��
 *           ����Ǿ�� �Ѵ�.<br>
 *           byte length(�ѱ�)�� �������� �ʴ´�.<br>
 *           ������Ʈ ����� onkeydown �̺�Ʈ�� ������ ���� ����� �־�߸� �Ѵ�.
 * <pre>
 *     �ֹι�ȣ
 *     &lt;input id="oSsn1" type="text" size="6" maxLength="6" onkeydown="cfAutoFocusNext(this, oSsn2)"&gt;-
 *     &lt;input id="oSsn2" type="text" size="7" maxLength="7"&gt;
 * </pre>
 * @sig    : oElement, oNextElement
 * @param  : oElement required ���� �Է��ʵ�
 * @param  : oNextElement required �ڵ����� ��Ŀ���� �̵��� �ʵ�
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
 * @desc   : ȭ����� ������ִ� �Լ�
 * @sig    : title, pageId[, features]
 * @param  : title  required ȭ���
 * @param  : pageId required ������ ���� ȭ�� id. ȭ���� ���ϸ��� ".html"�� ������ ��Ʈ���� �ָ� �ȴ�. �� �Ķ���ʹ�
 *                    ���� ������ ���� ���� �Ķ���ͷν� ���� ���򸻿� ���ؼ��� ���ǵ� ���� ����.
 * @param  : features optional ��Ÿ �Ӽ��� �����ϴ� ��Ʈ��. �Ӽ������� �Ʒ��� ����.
 * <pre>
 *     windowType : ����â�� ���� (0:�⺻â, 1:�˾�â, 2:���̾�α�â). (default:0)
 *     width      : ȭ�� ������ width. (default:638)
 *     height     : ȭ�� ������ height. (default:500)
 *     showHelp   : ���򸻹�ư�� �������� ����. (default:yes)<br>
 *     ��뿹) "width=300,height=300,showHelp=no"
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

        // ���������� ���������� iom �� �����Ͽ� �߻��ϴ� ���� ���� ����
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

	               "<span class='txtHelp' style='cursor:hand;' " + helpLink + ">����</span>";
    */
    var helpArea = "";
    //document.write("<div style='position:absolute; left:" + marginLeft + "; top:" + marginTop + "; '><img src='" + GLB_URL_COMMON_PAGE + "images/bullet_bodytitle.gif'><font class='txtTitleBody'>" + title + "</font></div>");
    //document.write("<div style='position:absolute; left:" + marginLeft + "; top:" + marginTop + "; '><img src='" + "images/bullet_bodytitle.gif'><font class='txtTitleBody'>" + title + "</font></div>");
    document.write("<div style='position:absolute; left:" + marginLeft + "; top:" + marginTop + "; '><font class='txtTitleBody'>" + title + "</font></div>");

	// ���� ��ư �ۼ�
	if (showHelp) {
		if (windowType == 1) {
			document.write("<div style='width:52; position:absolute; left:" + (helpAreaLeft + 10) + "; top:" + marginTop + ";'>" + helpArea + "</div>");
		} else if (windowType == 2) {
			document.write("<div style='width:52; position:absolute; left:" + (helpAreaLeft + 4) + "; top:" + marginTop + ";'>" + helpArea + "</div>");
		} else {
			document.write("<div style='width:52; position:absolute; left:" + helpAreaLeft + "; top:" + marginTop + ";'>" + helpArea + "</div>");
		}
	}

	// �� �κ��� ȭ�� ����� ����� ǥ���ϱ� ���� �κ����� ���谡 ���� �� ���� ����.
/*
	document.write("<table cellspacing='0' cellpadding='0' style='position:absolute; left:0; top:0;'><tr><td width='" + width + "' height='" + marginTop + "' bgcolor='#D6D6D6'></td></tr></table>");

	if (windowType == 1) {
		document.write("<table cellspacing='0' cellpadding='0' style='position:absolute; left:0; top:0;'><tr><td nowrap width='" + width + "' height='" + marginTop + "' bgcolor='#D6D6D6'></td></tr></table>");  // ��
		document.write("<div style='position:absolute; left:" + (rightSizeBarLeft + 10) + "; top:0;   width:" + (marginRight - 8) + ";  height:" + height + "; background-color:#D6D6D6;'></div>");               // ��
		document.write("<table cellspacing='0' cellpadding='0' style='position:absolute; left:0; top:" + bottomSizeBarTop + ";'><tr><td nowrap width='" + width + "' height='" + marginBottom + "' bgcolor='#D6D6D6'></td></tr></table>");  // ��
		document.write("<div style='position:absolute; left:0;   top:0;   width:" + marginLeft + ";  height:" + height + "; background-color:#D6D6D6;'></div>"); // ��
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
 * @desc   : cfFillGridHeader���� ����ϴ� �Լ�. �ش� �������� �����͸� ��û�Ѵ�.
 * @sig    : oDataSet, action, parameter, pageNo
 * @param  : oDataSet  required body���� div �±׷� ����� Header ���� element
 * @param  : action    required Grid�� DataId�� ����� DataSet ������Ʈ�� Reset()�ϱ� ���� ������ CommandŬ����.
 * @param  : parameter required �������� �о�������� �˻�����. Grid�� DataSet�� ù��° row�� param �÷��� ����.
 * @param  : pageNo    required ������ ������ ��ȣ
 * @param  : rsltCnt   required ������ �� �����ͼ�
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

 * @desc   : cfFillGridHeader���� ����ϴ� �Լ�. �ش� �������� �����͸� ��û�Ѵ�. startpageno/endpageno�� ������ resetó��

 * @sig    : oDataSet, action, parameter, pageNo

 * @param  : oDataSet  required body���� div �±׷� ����� Header ���� element

 * @param  : action    required Grid�� DataId�� ����� DataSet ������Ʈ�� Reset()�ϱ� ���� ������ CommandŬ����.

 * @param  : parameter required �������� �о�������� �˻�����. Grid�� DataSet�� ù��° row�� param �÷��� ����.

 * @param  : startPageNo - ���� ������ ��ȣ

 * @author : ���α�

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

 * @desc   : ����޼����� ���ǵ� �޼����� confirm box�� ������ �� �����Ѵ�. cfGetMsg ����.

 * @sig    : msgId[, paramArray]

 * @param  : msgId      required common.js�� ���� �޼��� ������ ����� �޼��� ID

 * @param  : paramArray optional �޼������� '@' ���ڿ� ġȯ�� ��Ʈ�� Array. (Array�� index��

 *           �޼��� ���� '@' ������ ������ ��ġ�Ѵ�.)

 * @return : ġȯ�� �޼��� ��Ʈ��

 * @author : GAUCE

 */

function cfConfirmMsg(msgId, paramArray) {

	if (cfIsNull(msgId)) {

		alert("�������� �ʴ� �޽����Դϴ�.");

		return null;

	}



	return confirm(new coMessage().getMsg(msgId, paramArray));

}



/**

 * @type   : function

 * @access : public

 * @desc   : ���콺�� �����ͼ� ������Ʈ ���� �����͸� �����Ѵ�. �������� �Ǵ� �����ͼ��� ������ �����ʹ� ��� �����ȴ�.

 *           features �Ķ���Ϳ��� copyHeader�� yes�� �� ��� DataSet�� �÷��������� ����ȴ�.

 * <pre>

 *    cfCopyDataSet(oDelivRsltOriginGDS, oDelivRsltCopiedGDS, "copyHeader=no");

 * </pre>

 * @sig    : oOriginDataSet, oTargetDataSet[, features]

 * @param  : oOriginDataSet required ���� DataSet

 * @param  : oTargetDataSet required ����Ǿ��� DataSet

 * @param  : features       optional ��Ÿ �Ӽ��� �����ϴ� ��Ʈ��. �Ӽ������� �Ʒ��� ����.

 * <pre>

 *     copyHeader  : Header�� �������� ����. (default:yes)

 *     resetStatus : ����� DataSet�� Status�� reset �� �� ����. (default:yes)

 *     rowFrom     : ������ row�� ���� index. (default:1)

 *     rowCnt      : ������ row�� ���� index. (default:DataSet.CountRow �� ��)

 *     ��뿹) "copyHeader=yes,rowFrom=1,rowCnt=2"  -> 1�� row ���� 3�� row���� Header�� �Բ� ������.

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

		var temp = oTargetDataSet.dataid;  // importdata�� �� �� DataSet�� ������ dataid �Ӽ����� �������� ���� ����.

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

 * @desc   : ���콺�� �����ͼ� ������Ʈ ���� �÷� ��� ������ �����Ѵ�.

 * <pre>

 *    cfCopyDataSet(oDelivRsltOriginGDS, oDelivRsltCopiedGDS);

 * </pre>

 * @sig    : oOriginDataSet, oTargetDataSet

 * @param  : oOriginDataSet required ���� DataSet

 * @param  : oTargetDataSet required ����Ǿ��� DataSet

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

		colIndex= oOriginDataSet.ColumnIndex(colId);  //column id�� �ش��ϴ� index��

		colSize = oOriginDataSet.ColumnSize(colIndex);//column size



		/* column�� type ���� �ڵ�



			Type  Description

			-----------------

			 1    String

			 2    Integer

			 3    Decimal

			 4    Date

			 5    URL

		*/



		//column type����

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



		/* column�� property ����

			0 : Normal (Key = No)

			1 : Constant

			2 : Key (Normal, Sequence)

			3 : Sequence (Key = No) // ���� �ǹ̾���.

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

 * @desc   : ���콺 Grid Object���� ����(�����ͼ��� ������) �Ǿ� �ִ� record�� �����Ͽ�

 			 �ٿ��ֱ�(�����ͼ¿� Row�� �߰�)�� �Ѵ�.

 * <pre>

 *    cfCopyRecord(oDataSet);

 * </pre>

 * @sig    : oDataSet

 * @param  : oDataSet required ����/�ٿ��ֱ��� ���� �����ͼ� �̸�

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

 * @desc   : Grid�� ���õ� Row���� �����Ѵ�.

 * <pre>

 *     cfDeleteGridRow(oDomRegiRecevGG);

 * </pre>

 * ���� ������ oDomRegiRecevGDS ��� id�� ���� Grid�� ���� ���õ� Row���� ��� �����ȴ�.<br><br>

 * <font color=red>

 * ������ cfDeleteGridRow �Լ��� �Ķ���ʹ� DataSet�̾����� Grid�� MultiRowSelect �Ӽ��� false�� ���

 * �� �Լ��� ����ϸ� ������ row�� ������ �� Grid�� ��� row�� �����Ǵ� ���װ� �־���. ���� �Ķ���Ͱ�

 * Grid�� �ٲ����. ������ ������ MultiRowSelect �Ӽ��� true�� ��쿡�� ������ �������Ƿ� ���� �ҽ�������

 * ������ �� ����. ���� ������ MultiRowSelect �Ӽ��� true �̸鼭 �Ķ���͸� DataSet���� ����� ��쿡��

 * ������� ���۵ǵ��� �ۼ��Ǿ���.

 * </font>

 *

 * @sig    : oGrid

 * @param  : oGrid required Grid ������Ʈ

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

 * @desc   : �ڹٽ�ũ��Ʈ�� ���� �տ� ������ �ڸ�����ŭ zero character �� �����Ѵ�.

 * <pre>

 *     cfDigitalNumber(5, 123);

 * </pre>

 * ���Ͱ��� ������� ��� "00123" �̶�� String�� �����Ѵ�.

 * @sig    : length, number

 * @param  : length required ���ڸ� ǥ���ϴ� ����
 * @param  : number required ��ȯ�� ����
 * @return : ��ȯ�� ��Ʈ��

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

 * @desc   : element�� disable ��Ų��.

 * <pre>

 *     cfDisable(oRegistBtn);

 * </pre>

 * @sig    : oElement

 * @param  : oElement required disable �ϰ��� �ϴ� element
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

	- <input type=text> �� ��� disable�ÿ� ���ڻ��� ������ �� ����. ���� disable ��� readOnly�� �ٲ۴�.

	- EMEdit�� ��� ���� disable�ÿ� ���ڻ��� ������ �� ����. ���� disable ��� readOnly�� �ٲ۴�.

	- ���콺 Radio�� ReadOnly�� ������ Enable�� false�� �����ϸ� ���ڻ��� �ٲ� ���� ����. ���ڻ��ٲ� ����.

	- <input type=checkbox> �� ��� ReadOnly�� ������ disabled�� true�� �� ��� box���� ������ �ٲ� ���� ����. box ���ٲ� ����.

	- ���콺 CodeCombo�� ��� InheritColor�Ӽ��� true�� �϶�� ���̵��Ͽ����� InheritColor�Ӽ��� true�� ���, ������

	  ���ڻ��� ��� �ٲ� ���� �ִ�. ��, ReadOnly�� ������ Enable�� false�� �ؾ� �Ѵ�. Enable�� false�� ���� ������ ���ڻ���

	  �����Ǿ �ٲ� ���� ����.

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

			//oElement.style.color = "#454648";  // �Ϲ� �ؽ�Ʈ �⺻����

			oElement.style.color = "#808080";    // EMEdit Disable�� ����� ����.

			oElement.style.backgroundColor = "#E9E9E9";  // HTML ������Ʈ�� �⺻ disabled color.

			                                             // Text�� background�� �Ͼ������ ���´�. ���� ��Ÿ�Ϸ� ���Ƿ� �����Ͽ���.

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

 * @desc   : element�� enable ��Ų��.

 * <pre>

 *     cfEnable(oRegistBtn);

 * </pre>

 * @sig    : oElement

 * @param  : oElement required enable �ϰ��� �ϴ� element Ȥ�� element array
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

 * @desc   : Grid�� ���� ������ ������ �����ִ� Grid Header�� �����Ѵ�. �� �Լ��� ����¡ ����� ����� ��� �ʿ��� �Լ��ν�

 *           �� �Լ��� ȣ���ϸ� ����¡�� ����ϴ� Grid�� Header �κп� ����¡ ������ �ڵ����� ��������. ������ Grid ������Ʈ��

 *           Header ������Ʈ�� id �� oDelivRsltGGHeader ��� �Ѵٸ�, ������ ���� �ش� Grid Header�� ä�� �� �ִ�.

 *           (����¡�� ���õ� ������ ȭ�� ���� ���̵� ������ �����ϱ� �ٶ���.)

 * <pre>

 * &lt;script language="javascript" for="oDelivRsltGDS" event="OnLoadCompleted()"&gt;

 *     cfFillGridHeader(oDelivRsltGGHeader, "pageLinkCnt=3");

 * &lt;/script&gt;

 * </pre>

 * @sig    : oGridHeader[, features]

 * @param  : oGridHeader required body���� div �±׷� ����� Grid Header ������Ʈ

 * @param  : features    optional ��Ÿ �Ӽ��� �����ϴ� ��Ʈ��. �Ӽ������� �Ʒ��� ����.

 * <pre>

 *     width        : Grid�� Width (default:608)

 *

 *     showTotal    : �� ��ȸ�Ǽ� ������ ���������� ����. ��ȸ�Ǽ� ������ ������ ���� ���·�

 *                    �������� ��������. (default:yes)

 *

 *                    �ѰǼ�:52

 *

 *     showPageInfo : "������������ȣ/��ü��������" ������ ������ ������ ���������� ����.

 *                    ������ ������ ������ ���� ���·� �������� ��������. (default:yes)

 *

 *                    ������:1/7

 *

 *     pageLinkCnt  : Grid�� ������ ��ũ�� ����. ��ũ������ �������� �������� ��ũ���� 0���� �ϸ� �ȴ�.

 *                    (�˻��� �������� 0�� ��쿡�� ȭ��� ��Ÿ���� �ʴ´�.)

 *                    �Ʒ��� ������ ��ũ���� 3 �� ����� ���� ���� �ִ�.

 *                    (default:5)

 *

 *                    ��[ 4 5 6 ]��

 *

 *     confirmChangePage : ���� �������� ����� ������ ������ ������� �ʾ��� ��쿡 Confirm Box�� ���������� ����.

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



	// �����̳��� �䱸�� ���� ������ �̵� ��ư�� ǥ������ ����.

	showPageBtn = false;



	if (cfIsNull(oTR)) {

		// Transaction �� ���� �˻��� ��쿡�� �˻� �� DataSet�� DataId�� �������Ƿ� Post ȣ������

		// cfSavePageParameter �Լ��� ���� ���������� ������ ���� ���� �̿��ؾ� �Ѵ�.

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

			prevBtn = "<a style='cursor:hand;' onclick=\"javascript:cfChangePage(" + oGridHeader.id + ", '" + action + "', '" + parameter + "', " + (pageNo - 1) + ", " + rsltCnt + ", " + confirmChangePage + ")\">�� </a>";

		}



		if (pageNo < pageCnt) {

			nextBtn = "<a style='cursor:hand;' onclick=\"javascript:cfChangePage(" + oGridHeader.id + ", '" + action + "', '" + parameter + "', " + (pageNo + 1) + ", " + rsltCnt + ", " + confirmChangePage + ")\">��</a>";

		}

	}



	if ( !isNaN(pageLinkCnt) && (pageLinkCnt != 0) && (pageNo != 0) ) {

		pageStartLinkNo = Math.floor( Math.abs(pageNo - 1) / pageLinkCnt ) * pageLinkCnt + 1;



		if (pageStartLinkNo == 1) {

			prevPageSetBtn = "";

		} else {

			prevPageSetBtn = "<a style='font-size:9pt; font-family:����; text-decoration:none; color:#212863; cursor:hand;' " +

			                 "onclick=\"cfChangePage(" +

			                 oGridHeader.id + ", '" + action + "', '" + parameter + "', " + (pageStartLinkNo - pageLinkCnt) + ", " + rsltCnt + ", " +

							 confirmChangePage + ")\">" + "�� " + "</a>";

		}



		if ((pageStartLinkNo + pageLinkCnt - 1) < pageCnt) {

			pageEndLinkNo = pageStartLinkNo + pageLinkCnt - 1;

			nextPageSetBtn = "<a style='font-size:9pt; font-family:����; text-decoration:none; color:#212863; cursor:hand;' " +

			                 "onclick=\"cfChangePage(" +

			                 oGridHeader.id + ", '" + action + "', '" + parameter + "', " + (pageStartLinkNo + pageLinkCnt) + ", " + rsltCnt + ", " +

							 confirmChangePage +  ")\">" + " ��" + "</a>";

		} else {

			pageEndLinkNo = pageCnt;

			nextPageSetBtn = "";

		}



		pageLinkArea = prevPageSetBtn + "<span style='font-size:9pt; font-family:����; color:#212863;'>[</span>";

		for (var i = pageStartLinkNo; i <= pageEndLinkNo; i++) {

			if (i != pageNo) {

				pageLinkArea = pageLinkArea + "<a style='font-size:9pt; font-family:����; text-decoration:none; color:#212863; cursor:hand;' " +

				               "onclick=\"cfChangePage(" +

				               oGridHeader.id + ", '" + action + "', '" + parameter + "', " + i + ", " + rsltCnt + ", " +

							   confirmChangePage + ")\"> " + i + " </a>";

			} else {

				pageLinkArea = pageLinkArea + "<span style='font-size:9pt; font-family:����; color:#5C8BE0; font-weight:bold;'> " + i + " </span>";

			}

		}

		pageLinkArea = pageLinkArea + "<span style='font-size:9pt; font-family:����; color:#212863;'>]</span>" + nextPageSetBtn;

	}



	if (showTotal) {

		totalArea = "<span style='font-size:9pt; font-family:����; color:#212863;'>�ѰǼ�: </span><span style='font-size:9pt; font-family:����; color:#5C8BE0; font-weight:bold'>"+ rsltCnt + "</span>";

	}



	if (showPageInfo) {

		pageInfoArea = "<span style='font-size:9pt; font-family:����; color:#212863;'>";

		if (showTotal == true) {

			pageInfoArea = pageInfoArea + "&nbsp;&nbsp;";

		}



		pageInfoArea = pageInfoArea +  "������: </span><span style='font-size:9pt; font-family:����; color:#5C8BE0; font-weight:bold;'>" + pageNo + "/" + pageCnt + "</span>";

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

 * @desc   : Grid�� ���� ������ ������ �����ִ� Grid Header�� �����Ѵ�. ������, pageinfo�� ����¡ ������

 *           �ְ� Grid ������Ʈ�� Header ������Ʈ�� id ��

 *           oDelivRsltGGHeader ��� �Ѵٸ�, ������ ���� �ش� Grid Header�� ä�� �� �ִ�.

 * <pre>

 * &lt;script language="javascript" for="oDelivRsltGDS" event="OnLoadCompleted()"&gt;

 *     cfFillGridHeaderPage(oDelivRsltGGHeader, pageInfo);

  * &lt;/script&gt;

 * </pre>

 * @sig    : oHeader,pageInfo

 * @param  : oHeader  - body���� div �±׷� ����� Grid Header�� id

 * @param  : pageInfo - Gauce dataset���� ������ pageinfo column��, Grid header�κп� ǥ���� ��ü Recoder ���� page��

  * <pre>

 *     width        : Grid�� Width (default:300)

  * <pre>

 *  	�ѰǼ�:52

 * </pre>

 *     showPageInfo : "��ü��������" ������ ������ ������ ���������� ����.

 *                    ������ ������ ������ ���� ���·� �������� ��������. (default:5)

 * <pre>

 *  	������:7

 * </pre>

 * @author : ���α�

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

		totalArea = "<span style='font-size:9pt; font-family:����; color:#212863;'>�ѰǼ�: </span><span style='font-size:9pt; font-family:����; color:#5C8BE0; font-weight:bold'>"+ rsltCnt + "</span>";

	}



	if (showPageInfo) {

		pageInfoArea = "<span style='font-size:9pt; font-family:����; color:#212863;'>";

		if (showTotal == true) {

			pageInfoArea = pageInfoArea + "&nbsp;&nbsp;";

		}



		pageInfoArea = pageInfoArea +  "������: </span><span style='font-size:9pt; font-family:����; color:#5C8BE0; font-weight:bold;'>" +"</span>";

	}



	oHeader.innerHTML = "<table cellpadding='0' cellspacing='0' width='" + width + "'>" +

	                    "    <tr>" +

	                    "        <td align='left' width='1%' nowrap>" + totalArea +"</td>" +

	                    "        <td align='left'>"+pageInfoArea+"<font id='page_cnt' style='font-size:9pt; font-family:����; color:#5C8BE0; font-weight:bold;'><font></td>" +

                        "    </tr>" +

                        "</table>";

                        page_cnt.innerText = pageCnt;

}



/**

 * @type   : function

 * @access : public

 * @desc   : cfFillGridHeader�Լ� ����ϸ� ������ ���� paging����� �߰��Ͽ���.(page from - to�������� paramater�� �޴´�)

 			 Grid�� ���� ������ ������ �����ִ� Grid Header�� �����Ѵ�. �� �Լ��� ����¡ ����� ����� ��� �ʿ��� �Լ��ν�

 *           �� �Լ��� ȣ���ϸ� ����¡�� ����ϴ� Grid�� Header �κп� ����¡ ������ �ڵ����� ��������. ������ Grid ������Ʈ��

 *           Header ������Ʈ�� id �� oDelivRsltGGHeader ��� �Ѵٸ�, ������ ���� �ش� Grid Header�� ä�� �� �ִ�.

 *           (����¡�� ���õ� ������ ȭ�� ���� ���̵� ������ �����ϱ� �ٶ���.)

 * <pre>

 * &lt;script language="javascript" for="oDelivRsltGDS" event="OnLoadCompleted()"&gt;

 *     cfFillGridHeaderPeriod(oDelivRsltGGHeader, "pageLinkCnt=3");

 * &lt;/script&gt;

 * </pre>

 * @sig    : oGridHeader[, features]

 * @param  : oGridHeader required body���� div �±׷� ����� Grid Header ������Ʈ

 * @param  : features    optional ��Ÿ �Ӽ��� �����ϴ� ��Ʈ��. �Ӽ������� �Ʒ��� ����.

 * <pre>

 *     width        : Grid�� Width (default:608)

 *

 *     showTotal    : �� ��ȸ�Ǽ� ������ ���������� ����. ��ȸ�Ǽ� ������ ������ ���� ���·�

 *                    �������� ��������. (default:yes)

 * <pre>

 *  	�ѰǼ�:52

 * </pre>

 *     showPageInfo : "������������ȣ/��ü��������" ������ ������ ������ ���������� ����.

 *                    ������ ������ ������ ���� ���·� �������� ��������. (default:yes)

 * <pre>

 *  	������:1/7

 * </pre>

 *     pageLinkCnt  : Grid�� ������ ��ũ�� ����. ��ũ������ �������� �������� ��ũ���� 0���� �ϸ� �ȴ�.

 *                    �Ʒ��� ������ ��ũ���� 3 �� ����� ���� ���� �ִ�.

 *                    (default:5)

 * <pre>

 *  	��[ 4 5 6 ]��

 * </pre>

 *     confirmChangePage : ���� �������� ����� ������ ������ ������� �ʾ��� ��쿡 Confirm Box�� ���������� ����.

 *                    (default:yes)

 * @author : ���α�

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



	// �����̳��� �䱸�� ���� ������ �̵� ��ư�� ǥ������ ����.

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

			prevBtn = "<a style='cursor:hand;' onclick=\"cfChangePage(" + dataId + ", '" + action + "', '" + parameter + "', " + (startPageNo - 1) + ", " + confirmChangePage + ")\">�� </a>";

		}



		if (startPageNo < pageCnt) {

			nextBtn = "<a style='cursor:hand;' onclick=\"javascript:cfChangePage(" + dataId + ", '" + action + "', '" + parameter + "', " + (startPageNo + 1) + ", " + confirmChangePage + ")\">��</a>";

		}

	}



	if ( !isNaN(pageLinkCnt) && (pageLinkCnt != 0) && (startPageNo != 0) ) {

		pageStartLinkNo = Math.floor( Math.abs(startPageNo - 1) / pageLinkCnt ) * pageLinkCnt + 1;



		if (pageStartLinkNo == 1) {

			prevPageSetBtn = "";

		} else {

			prevPageSetBtn = "<a style='font-size:9pt; font-family:����; text-decoration:none; color:#212863; cursor:hand;' " +

			                 "onclick=\"cfChangePagePeriod(" +

			                 dataId + ", '" + action + "', '" + parameter + "', " + (pageStartLinkNo - pageLinkCnt) +

			                 ", " + confirmChangePage + ")\">" + "�� " + "</a>";

		}



		if ((pageStartLinkNo + pageLinkCnt - 1) < pageCnt) {

			pageEndLinkNo = pageStartLinkNo + pageLinkCnt - 1;

			nextPageSetBtn = "<a style='font-size:9pt; font-family:����; text-decoration:none; color:#212863; cursor:hand;' " +

			                 "onclick=\"cfChangePagePeriod(" +

			                 dataId + ", '" + action + "', '" + parameter + "', " + (pageStartLinkNo + pageLinkCnt) +

			                 ", " + confirmChangePage + ")\">" + " ��" + "</a>";

		} else {

			pageEndLinkNo = pageCnt;

			nextPageSetBtn = "";

		}



		pageLinkArea = prevPageSetBtn + "<span style='font-size:9pt; font-family:����; color:#212863;'>[</span>";

		for (var i = pageStartLinkNo; i <= pageEndLinkNo; i++) {

			if (i != startPageNo) {

				pageLinkArea = pageLinkArea + "<a style='font-size:9pt; font-family:����; text-decoration:none; color:#212863; cursor:hand;' " +

				               "onclick=\"cfChangePagePeriod(" +

				               dataId + ", '" + action + "', '" + parameter + "', " + i +

				               ", " + confirmChangePage + ")\"> " + i + " </a>";

			} else {

				pageLinkArea = pageLinkArea + "<span style='font-size:9pt; font-family:����; color:#5C8BE0; font-weight:bold;'> " + i + " </span>";

			}

		}

		pageLinkArea = pageLinkArea + "<span style='font-size:9pt; font-family:����; color:#212863;'>]</span>" + nextPageSetBtn;

	}



	if (showTotal) {

		totalArea = "<span style='font-size:9pt; font-family:����; color:#212863;'>�ѰǼ�: </span><span style='font-size:9pt; font-family:����; color:#5C8BE0; font-weight:bold'>"+ rsltCnt + "</span>";

	}



	if (showPageInfo) {

		pageInfoArea = "<span style='font-size:9pt; font-family:����; color:#212863;'>";

		if (showTotal == true) {

			pageInfoArea = pageInfoArea + "&nbsp;&nbsp;";

		}



		pageInfoArea = pageInfoArea +  "������: </span><span style='font-size:9pt; font-family:����; color:#5C8BE0; font-weight:bold;'>" + startPageNo + "/" + pageCnt + "</span>";

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

 * @desc   : Grid�� DataId�� ������ DataSet�� �����Ͱ� 0���� ��쿡�� "�����Ͱ� �����ϴ�." ��� �޽����� Grid�� �����ش�.

 *           �����Ͱ� ���� ��쿡�� �޽����� ������ ������ ������ �̹� ������ ��쿡�� �޽����� �������.<br>

 *           ���� ȣ���ϵ��� ��������� ���� DataSet�� OnLoadCompleted �̺�Ʈ�� Transaction�� OnSuccess �̺�Ʈ���� ȣ���Ѵ�.

 * <pre>

 *     &lt;script language="javascript" for="oDelivRsltGDS" event="OnLoadCompleted()"&gt;

 *         cfFillGridHeader(oDelivRsltGGHeader, oDelivRsltGDS, "kpl.spl.common.svl.SplSVL", "kpl.spl.sb.fnc.cmd.RetrieveDelivRsltListCMD", "pageLinkCnt=3");

 *         <b>cfFillGridNoDataMsg(oDelivRsltGG, "gridColLineCnt=2");</b>

 *     &lt;/script&gt;

 * </pre>

 * @sig    : oGG[, features]

 * @param  : oGG      required Grid ������Ʈ

 * @param  : features optional ��Ÿ �Ӽ��� �����ϴ� ��Ʈ��. �Ӽ������� �Ʒ��� ����.

 * <pre>

 *     gridColLineCnt : Grid�� �÷� ���� ��. �Ϲ������δ� �� �������� Grid�� Ÿ��Ʋ�� ���� 2�� �� ���̴�. �⺻���� 1�̴�.

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

	oNoDataMsg.Text              = "�����Ͱ� �����ϴ�.";

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

 * @desc   : �������� ����ð��� �о�ͼ� �ڹٽ�ũ��Ʈ�� Date ������Ʈ�� ��ȯ�Ѵ�.

 *           Date ������Ʈ�κ��� ��Ʈ�� ���·� ��¥ Ȥ�� �ð��� �������� Date.format() �޼ҵ带 ������ ��.

 * @return : Date ������Ʈ

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



		// </head> �±� ������ DataSet ����

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

 * @desc   : Element�� type�� �˷��ش�. ���ϵǴ� element type string�� ������ ����.

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

 *     GCC      : ���콺 CodeCombo

 *     GRDO     : ���콺 Radio

 *     GTA      : ���콺 TextArea

 *     GIF      : ���콺 InputFile

 *     GE       : ���콺 EMEdit

 *     GDS      : ���콺 DataSet

 *     GTR      : ���콺 Transaction

 *     GCHT     : ���콺 Chart

 *     GID      : ���콺 ImageData

 *     GG       : ���콺 Grid

 *     GTB      : ���콺 Tab

 *     GTV      : ���콺 TreeView

 *     GM       : ���콺 Menu

 *     GB       : ���콺 Bind

 *     GRPT     : ���콺 Report

 *     GS       : ���콺 Scale

 *     null     : ��Ÿ

 * </pre>

 * @sig    : oElement

 * @param  : oElement required element
 * @return : element�� type�� ǥ���ϴ� string

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

 * @desc   : ��Ʈ���� �ڸ����� Byte ������ ȯ���Ͽ� �˷��ش�. ����, ���ڴ� 1Byte�̰� �ѱ��� 2Byte�̴�.(��/�� �߿� �ϳ��� �ִ� ���ڵ� 2Byte�̴�.)

 * @sig    : value

 * @param  : value required ��Ʈ��

 * @return : ��Ʈ���� ����

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

 * @desc   : ����޼����� ���ǵ� �޼����� �����Ѵ�.

 * <pre>

 * // ���� �޼��� ����

 * var MSG_NO_CHANGED        = "����� ������ �����ϴ�.";

 * var MSG_SUCCESS_LOGIN     = "@�� �ȳ��ϼ���?";

 * ...

 * var message1 = cfGetMsg(MSG_NO_CHANGED);

 * var message2 = cfGetMsg(MSG_SUCCESS_LOGIN, ["ȫ�浿"]);

 * </pre>

 * ���� ������ message2 �� ���� "ȫ�浿�� �ȳ��ϼ���?" �� �ȴ�.

 * @sig    : msgId[, paramArray]

 * @param  : msgId      required common.js�� ���� �޼��� ������ ����� �޼��� ID

 * @param  : paramArray optional �޼������� '@' ���ڿ� ġȯ�� ������ Array. Array�� index��

 *           �޼��� ���� '@' ������ ������ ��ġ�Ѵ�. ġȯ�� �����ʹ� [] ���̿� �޸��� �����ڷ� �Ͽ� ����ϸ� Array �� �νĵȴ�.

 * @return : ġȯ�� �޼��� ��Ʈ��

 * @author : GAUCE

 */

function cfGetMsg(msgId, paramArray) {

	return new coMessage().getMsg(msgId, paramArray);

}



/**

 * @type   : function

 * @access : public

 * @desc   : �������� Ŭ���̾�Ʈ�� DataSet�� pageInfo �÷��� �̿��� �Ķ���͸� �������� ��� Ŭ���̾�Ʈ���� �Ķ���͸� ��� �Լ��̴�.

 *           �������� ������ �Ķ���͸� �ִ� ����� Paging�� ����� ���� ����ϴ�.<br>

 * <pre>

 *           1. ������ �Ķ���͸� �������� DataSet�� pageInfo �÷��� �߰��Ѵ�.

 *              dataSet.MakeDataSetInfo("pageInfo", gauceDefine.TB_STRING);

 *

 *           2. pageInfo �����͸� �����Ͽ� DataSet�� ù��° row�� pageInfo�÷��� pageInfo ������ �����Ѵ�.

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

 *           4. ȭ�鿡�� cfGetPageInfo �Լ��� �̿��� ���� ������.

 *              cfGetPageInfo(oDelivGDS);

 *              cfGetPageInfo(oDelivGDS, "p1");

 *              cfGetPageInfo(oDelivGDS, "p1", "default value");

 * </pre>

 * @sig    : oDataSet[, paramName[, defaultValue]]

 * @param  : oDataSet     required pageInfo �� ����ִ� DataSet
 * @param  : paramName    optional pageInfo �߿��� ����� �ϴ� �Ķ������ �̸�
 * @param  : defaultValue optional paramName�� �ش��ϴ� �Ķ���Ͱ� �������� ���� ��� ���ϵǴ� �⺻��.
 * @return : paramName�� ���� ��쿡�� pageInfo ��Ʈ�� ��ü�� �����ϰ� paramName�� ���� ���� �ش� �Ķ������ ���� �����Ѵ�.

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

 * @desc   : �ѹ� �˻��� DataSet�� DataId�� �����Ǿ� �ִ� �Ķ���� ��Ʈ���� ��� ���� �Լ�. �ַ� ����¡��

 *           ����� �� ���ȴ�.

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

 * ���� ���� DataId �� �ۼ��Ͽ� DataSet�� �˻��Ͽ��ٰ� ����. �� �� oDelivYmd.Text �� ���� "20020913" �̾���

 * oDelivSeqCd.CodeValue �� ���� "001" �̾��ٰ� �� ���, parameter �� ���� ��Ʈ�� �κ���

 * �ٽ� ��� ���ؼ��� �Ʒ��� ���� �ϸ� �ȴ�.

 * <pre>

 *     var param = cfGetPageParameter(oDelivRsltGDS);

 * </pre>

 * ������ param �� ���� "&delivYmd=20020913&delivSeqCd=001&pageSize=8&pageNo=1" �� �ȴ�.

 * @sig    : oDataSet

 * @param  : oDataSet required parameter string�� ����� �ϴ� DataSet ��ü.

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

 * @desc   : popup���� radio button ����� ó��

 * @sig    : oTypeGR, oStartPageNo, oEndPageNo

 * @param  : oTypeGR - radio button object id

 * @param  : oStartPageNo - start page�� ��Ÿ�� emedit object id

 * @param  : oEndPageNo -  end page�� ��Ÿ�� emedit object id

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

 * @desc   : Object�� �ʱ�ȭ�Ѵ�.

 * @sig    : obj[, iniVal]

 * @param  : parentObj required �ʱ�ȭ�� ��� ������Ʈ

 * @param  : iniVal    optional �ʱⰪ

 * @author : �����

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

 * @desc   : ����ڰ� ���� key�� enter key ���� ���θ� �˷��ش�.

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

 * @return : enter key ����

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

 * @desc   : ���� null �̰ų� white space ���ڷθ� �̷���� ��� true�� �����Ѵ�.

 * <pre>

 *     cfIsNull("  ");

 * </pre>

 * ���Ͱ��� ������� ��� true�� �����Ѵ�.

 * @sig    : value

 * @param  : value required �Է°�
 * @return : boolean. null(Ȥ�� white space) ����

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

 * @desc   : ���� ������ �׷쳻�� �����ϴ����� �˷��ش�.

 * <pre>

 *     cfIsIn(3, [1, 2, 3]);                     // -> true

 *     cfIsIn(3, [4, 5, 6]);                     // -> false

 *     cfIsIn('F', ['A', 'B', 'F']);             // -> true

 *     cfIsIn('F', ['A', 'B', 'C']);             // -> false

 *     cfIsIn("lim", ["lim", "kim", "park"]);    // -> true

 *     cfIsIn("lim", ["lee", "kim", "park"]);    // -> false

 * </pre>

 * @sig    : value, valueArray

 * @param  : value      required ���ϰ� ���� ��
 * @param  : valueArray required ���ϰ� ���� ���� ���� �� ����� �Ǵ� ������ ����. array Ÿ���̸� array

 *           ���� �� element�� ������ Ÿ���� value �Ķ������ Ÿ�԰� ��ġ�ؾ� �Ѵ�.

 * @return : boolean. ���� ������ �׷쳻�� �����ϴ��� ����.
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

 * @desc   : �������� �ٸ� �������κ��� �ε�� ���������� ���θ� �˷��ش�.

 * @sig    : pageId

 * @param  : pageId required ���� ������ id
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

 * @desc   : �������� �̵��� �� �Ķ���� �� DataSet�� �����ϱ� ���� �Լ�.

 * <pre>

 *     in.html ���������� out.html �� �������� �̵��ϸ鼭 2���� �Ķ���Ϳ� 2���� DataSet�� �����ϰ��� �Ѵ�.

 *     ������ �Ķ���ʹ� param1�� param2�̸� ������ DataSet�� id�� ���� oPmanGDS �� oDAreaGDS �̴�.

 *     �� �� in.html ���� �����ؾ� �� ������ ������ ����.

 *

 *         1. coParameterMap ��ü�� �����Ѵ�. (coParameterMap ��ü�� ���� ������ document�� ����)

 *            var paramMap = new coParameterMap();

 *

 *         2. coParameterMap ��ü�� ������ �Ķ���� �����͸� ä���.

 *	          paramMap.put("param1", "paramvalue1");

 *            paramMap.put("param2", "paramvalue2");

 *

 *         3. cfNaviPageIn �Լ��� ȣ���Ѵ�.

 *            cfNaviPageIn("out.html", paramMap, "pman=oPmanGDS,dArea=oDAreaGDS");

 *

 *            <font color=red>

 *            ������ : �� �Լ��� ��ü ȭ�鿡 ���� ������ ������ ����� �ε�Ǿ� ���� �����鿡���� ����.

 *                     ���� ������ �� ��� �ý��� �ʱ�ȭ����� ����� �ε�� �������� Ȯ���� ���� �ٶ���.

 *            </font>

 * </pre>

 * @sig    : receivePageId, paramMap[, dataSetKeyValue]

 * @param  : receivePageId   required ������ �������� id(.html�� ������ ���ϸ�� ����)
 * @param  : paramMap        required ������ �Ķ���͸� ��� �ִ� coParameterMap ��ü
 * @param  : dataSetKeyValue optional ������ DataSet�� ���� ������ ���Ŀ� �°� ǥ���� ��Ʈ��.

 * <pre>

 *     ���� : "key=dataset_id, ..."

 *     ��   : "pman=oPmanGDS,dArea=oDAreaGDS"

 * </pre>

 * @author : GAUCE

 */

function cfNaviPageIn(receivePageId, paramMap, dataSetKeyValue) {

	// MainNaviFrame�� head element ã��

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



		// MainNaviFrame�� head ���� ��� DataSet ����

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



	// MainNaviFrame �� navigation�� ���� parameter �����

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



			// ����� DataSet �����

			dataSet = document.createElement("<OBJECT>");

			dataSet.classid = "CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49";

			dataSet.id = key;

			head.insertAdjacentElement("beforeEnd", dataSet);



			// ����� DataSet�� ������ �ֱ�

			originDataSet = document.all(value);

			cfCopyDataSet(originDataSet, dataSet);

		}

	}



	location.href = receivePageId + ".html";

}



/**

 * @type   : function

 * @access : public

 * @desc   : �������� �̵��� �� �Ķ���� �� DataSet�� ���޹ޱ� ���� �Լ�. cfNaviPageIn �Լ��� ���� ������ �� �����Ͽ��ٰ� �����Ѵ�.

 * <pre>

 *     in.html �κ��� out.html �������� �̵��ϸ鼭 2���� �Ķ���Ϳ� 2���� DataSet�� �����ϰ��� �Ѵ�. ������ �Ķ���ʹ� param1�� param2�̸�

 *     ������ DataSet�� id�� ���� oPmanGDS �� oDAreaGDS �̴�. �� �� out.html���� �����ؾ� �� ������ ������ ����.

 *

 *         1. ���޹޾ƾ� �� DataSet�� ��� DataSet�� ����Ǿ� �־�� �Ѵ�. ��, in.html���� ���޵Ǵ� �� ���� DataSet(oPmanGDS, oDAreaGDS)��

 *            ���� �� �ִ� �� ���� DataSet�� ����Ǿ� �־�� �Ѵ�. (���⼭�� oPmanOutGDS�� oDAreaOutGDS ��� �����Ѵ�.)

 *

 *         2. body�� onload �̺�Ʈ �߻��� ������ ���� ó���� �ش�.

 *            1) cfIsNaviPage �Լ�(document�� ����) �� �̿��ؼ� ���� �������� �ٸ� �������� ���� �ε�� ������,

 *               �ƴϸ� �׳� �޴��� �����ؼ� �ε�� ������ Ȯ���Ѵ�.

 *

 *		         if (cfIsNaviPage("out")) {

 *                   ...

 *               }

 *

 *            2) ���� �ٸ� ������(in.html)�� ���� �ε�� ���̶�� cfNaviPageOut �Լ��� ȣ���Ѵ�.

 *

 *               var paramMap = cfNaviPageOut("out", "pman=oPmanOutGDS,dArea=oDAreaOutGDS");

 *              (�� ��, �ι�° �Ķ������ key ����(pman, dArea) in.html���� ����� key ���� �����ؾ� �Ѵ�.)

 *

 *            3) ���� ���� ���������� �Ķ���͸� �Ѱ�ٸ� paramMap �������� coParameterMap ��ü(document �����Ұ�) �� ���Ϲ��� ���̴�.

 *               ���޹��� �Ķ���ʹ� paramMap ������ �̿��ؼ� ����ϸ� �ȴ�.

 *               ���� ���޹��� DataSet�� 1������ ������ DataSet�� ������� ���̴�.

 * </pre>

 * @sig    : pageId[, dataSetKeyValue]

 * @param  : pageId          required ���� �������� id(.html�� ������ ���ϸ�� ����)
 * @param  : dataSetKeyValue optional ���޹޴� DataSet�� ���� ������ ���Ŀ� �°� ǥ���� ��Ʈ��.

 * <pre>

 *     ���� : "key=dataset_id, ..."

 *     ��   : "pman=oPmanGDS,dArea=oDAreaGDS"

 *     <font color=red>������</font> : �� �� key ���� in.html���� cfNaviPageIn �Լ��� dataSetKeyValue �Ķ���� �ۼ��� ����ߴ� key�� �����ؾ� �Ѵ�.

 * </pre>

 * @return : �Ѱܹ��� �Ķ���Ͱ� ���� ��� �� �Ķ���������� ��� �ִ� coParameter ��ü�� ���ϵȴ�.

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



			// ����� DataSet�� ������ �ֱ�

			originDataSet = GLB_FRAME_MAIN_NAVI.document.all(key);

			cfCopyDataSet(originDataSet, document.all(value));

		}

	}



	// MainNaviFrame ���κ��� navigation�� ���� parameter ���� �о coParameterMap ��ü�� �����

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



		// MainNaviFrame�� head element ã��

		for (var i = 0; i < GLB_FRAME_MAIN_NAVI.document.all.length; i++) {

			if (GLB_FRAME_MAIN_NAVI.document.all[i].tagName == "HEAD") {

				head = GLB_FRAME_MAIN_NAVI.document.all[i];

				break;

			}

		}



		// MainNaviFrame�� head ���� ��� DataSet ����

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

 * @desc   : window.open���� ����â�� ��� �� ����â�� ��ġ�� �����ϰ� ������ �� �ִ�.

 * @sig    : width, height, position, [sURL] [, sName] [, sFeatures] [, bReplace]

 * @param  : width - ����â�� ����

 * @param  : height - ����â�� ����

 * @param  : position  - ����â�� ��ġ (default : 5) <br><br>

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

 * @param  : sURL      required window.open�� sURL �Ķ���Ϳ� ����

 * @param  : sName     required window.open�� sName �Ķ���Ϳ� ����

 * @param  : sFeatures required window.open�� sFeatures �Ķ���Ϳ� ����

 * @param  : bReplace  required window.open�� bReplace �Ķ���Ϳ� ����

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

		width = width + 10; // window�� �¿� border 5px�� ����.

		height = height + 29; // titlebar�� �⺻���� ����.

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

 * @desc   : features ��Ʈ���� �Ľ��Ͽ� array�� �����ϴ� ���� �Լ�

 * @sig    : features, fNameArray, fValueArray, fTypeArray

 * @param  : features    required features�� ǥ���� ��Ʈ��

 * @param  : fNameArray  required �����ؾ� �� feature�� �̸��� ���� array

 * @param  : fValueArray required �����ؾ� �� feature�� �⺻���� ���� array

 * @param  : fTypeArray  required �����ؾ� �� feature�� ������Ÿ�Կ� ���� array

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

 * @desc   : ���� popup���� ��ü ���ڵ��/��������, ��°��� ������ �����Ѵ�.

 * @sig    : oPagePrintMsg, oTypeGR, oStartPageNo, oEndPageNo

 * @param  : oPagePrintMsg - �ѰǼ�/������������ ��Ÿ�� div tag id

 * @param  : oTypeGR - radio button object id

 * @param  : oStartPageNo - start page�� ��Ÿ�� emedit object id

 * @param  : oEndPageNo -  end page�� ��Ÿ�� emedit object id

 * @author : ���α�

 */

function cfPrintPopupSetting(oPagePrintMsg, oTypeGR, oStartPageNo, oEndPageNo){


/* 2003.05.22 �������� ���� �����ɻ���
		oPagePrintMsg.innerHTML =

			"<table width='300' style='position:absolute; left:'30'; top:'170'; cellspacing='0' cellpadding='0'>"+

			"<tr><td align='left'><font id='oMaxPage' style='font-size:9pt; font-family:����; color:#5C8BE0; font-weight:bold;'><font></td>"+

			"<td><font  style='font-size:9pt; font-family:����; color:#212863; font-weight:bold;'><font>&nbsp������ �̻��� ����Ҽ� �����ϴ�.</td></tr></table>";





		//oTypeGR : gauce radio button object id,oStartPageNo : gauce emedit startpage id, oEndPageNo : gauce emedit endpage id

		oMaxPage.innerText = GLB_REPORT_MAXPAGE; //������ ��½� ���� ������ ����

*/

		Parm = window.dialogArguments;



		DSDataid     = Parm.DataId;   //dataset dataid

		pageInfo     = Parm.PageInfo; //page



		cfFillGridHeaderPage(oRegistGGHeader,pageInfo);



		//page_cnt.innerText page��

		//GLB_REPORT_MAXPAGE  �ִ밡�� page��

		if( page_cnt.innerText < GLB_REPORT_MAXPAGE ){

			//�ִ� ���������� ���� �������� ������� ��ü��°���

			oTypeGR.CodeValue     = 1;

			oStartPageNo.text     = 1;

			oEndPageNo.text       = page_cnt.innerText;

			oEndPageNo.ReadOnly   = true;

			oStartPageNo.ReadOnly = true;

		}

		else{

			//�ִ� ���������� ���� �������� ū��� �κ���°���

			oStartPageNo.text     = 1;

			oEndPageNo.text       = 100;

			oTypeGR.CodeValue 	  = 2;

			oTypeGR.Enable    	  = false;

		}

}



/**

 * @type   : function

 * @access : private

 * @desc   : html�󿡼� parent element�� ���� child element �鿡 ���� �ϰ������� ������ �Լ��� �����Ų��.

 * @sig    : parentObj, fnc[, argArr]

 * @param  : parentObj required parent object

 * @param  : fnc required �� input element ���� �����ų �Լ� ������

 * @param  : argArr optional �Լ��� ������ �Ķ����. �� �޼ҵ带 ���� ȣ��Ǵ� �Լ��� ������ �� ���� �Ķ���ͷθ�

 *           �����Ǿ�� �Ѵ�. �ϳ��� ó���Ϸ��� element, ������ �ϳ��� ó���� �ʿ��� �Ķ���͵��� array ��ü�̴�.

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

 * @desc   : ����޼����� ���ǵ� �޼����� prompt box �� �����ش�. ���� �н����带 �Է¹޴� prompt box��

 *           ���鼭 ����޼����� ���ǵ� �޼����� �����ְ� �ʹٸ� ������ ���� �ϸ� �ȴ�.

 * <pre>

 *     // ����޼��� ����

 *     var MSG_INPUT_PASSWORD = "@��, �н����带 �Է��Ͻʽÿ�.";

 *     ...

 *     cfPromptMsg(MSG_INPUT_PASSWORD, ["ȫ�浿"], "�Է��ϼ���.");

 * </pre>

 * @sig    : msgId[, paramArray[, defaultVal]]

 * @param  : msgId      required common.js�� ���� �޼��� ������ ����� �޼��� ID

 * @param  : paramArray optional �޼������� '@' ���ڿ� ġȯ�� ��Ʈ�� Array. (Array�� index��

 *           �޼��� ���� '@' ������ ������ ��ġ�Ѵ�.)

 * @param  : defaultVal optional prompt box �� �Է��ʵ忡 ������ �⺻��.

 * @return : �Է¹��� String Ȥ�� Integer Ÿ���� �н����� ������

 * @author : GAUCE

 */

function cfPromptMsg(msgId, paramArray, defaultVal) {

	if (cfIsNull(msgId)) {

		alert("�������� �ʴ� �޽����Դϴ�.");

		return null;

	}



	return prompt(new coMessage().getMsg(msgId, paramArray), defaultVal);

}



/**

 * @type   : function

 * @access : public

 * @desc   : parent object (Div, Table, FieldSet �±�)�� ���� ��� child object�� ���� �ʱ�ȭ�Ѵ�.

 * @sig    : parentObj[, iniVal]

 * @param  : parentObj required �ʱ�ȭ�� �θ� ������Ʈ

 * @param  : iniVal    optional �ʱⰪ

 * @author : ���ȣ

 */

function cfReset(parentObj, iniVal) {

	cfProcessChildElement(parentObj, cfIniObject);

}



/**

 * @type   : function

 * @access : public

 * @desc   : Paging �� ����ϴ� DataSet�� Transaction �� �̿��ؼ� ��ȸ�� �� ��쿡 ��ȸ�� �Ŀ��� Paging �� �����

 *           �����ϱ� ���ؼ��� Transaction ���� ���� �ش� DataSet�� Paging�� �ʿ��� �Ķ���͵��� �̸� ������ �ξ�� �Ѵ�.

 *           �� �� �� �Լ��� ����Ѵ�. ����¡�� ���õ� ������ ȭ�鰳�߰��̵带 ������ ��.

 * <pre>

 *      ��) oDelivRsltGTR ������Ʈ�� ���� Transaction ó���� �ϰ��� �� �� Transaction�� ���� oDelivRsltGDS DataSet�� �о����,

 *          oDelivRsltGDS DataSet�� ����¡�� ����ؾ� �ϴ� ��� �Ʒ��� ���� �Ķ���͸� Post() ���� �����Ѵ�.

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

 * @param  : oDataSet required DataSet ������Ʈ

 * @param  : parameter required DataSet�� Paging�� �ʿ��� �Ķ���͸� ǥ���ϴ� ��Ʈ��

 * @author : GAUCE

 */

function cfSavePageParameter(oDataSet, parameter) {

	GLB_PAGE_PARAMS.put(oDataSet.id, parameter);

}



/**

 * @type   : function

 * @access : public

 * @desc   : Grid�� ��ü�����Ѵ�.

 * <pre>

 *     cfSelectAllGridRows(oDomRegiRecevGDS, oDomRegiRecevGG);

 * </pre>

 * ���� ������ oDomRegiRecevGDS ��� id�� ���� DataSet�� �����͸� �����ִ�

 * oDomRegiRecevGG ��� id�� ���� Grid �󿡼� ��� Row���� �����Ѵ�.

 * @sig    : dataSet, grid

 * @param  : dataSet required DataSet ������Ʈ�� id

 * @param  : grid    required Grid ������Ʈ

 * @author : GAUCE

 */

function cfSelectAllGridRows(oDataSet, oGrid) {

	oDataSet.MarkAll();

	oGrid.Focus();

}



/**

 * @type   : function

 * @access : public

 * @desc   : �������� ����ϴ� �޷�â�� ����.

 * <pre>

 * 1. EMEdit�� �Բ� ����� ���

 *     &lt;object id="calendarText" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F" width="100"&gt;

 *         &lt;param name="Alignment" value="1"&gt;

 *         &lt;param name="format" value="YYYY-MM-DD"&gt;

 *     &lt;/object&gt;

 *

 *     &lt;input type="button" value="�޷¶���" onclick="cfShowCalendar(calendarText)"&gt;

 * 2. Grid�� �Բ� ����� ���

 *     ...

 *

 *     &lt;script language="javascript"  for=<b>"oGG"</b> event=<b>"OnPopup(Row, Colid, data)"</b>&gt;

 *         <b>cfShowCalendar(oCalendarGG);</b>

 *     &lt;/script&gt;

 *

 *     ...

 *

 *     &lt;!-- Grid Component ( ��ް����ȸ ) --&gt;

 *     &lt;object id=<b>"oGG"</b> classid="CLSID:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" width="250" height="100"&gt;

 *         &lt;param name="DataID"         value=<b>"oGDS"</b>&gt;

 *         &lt;param name="Editable"       value="true"&gt;

 *         &lt;param name="Format"         value='

 *     	       &lt;C&gt; ID="delivYmd",    Name="�������", Width="100", <b>EditStyle="Popup", Mask="XXXX-XX-XX"</b>&lt;/C&gt;

 *     	       &lt;C&gt; ID="recPrsnName", Name="������",   Width="70"&lt;/C&gt;

 *             ...

 *     	   '&gt;

 *     &lt;/object&gt;

 *

 * </pre>

 * @sig    : item[, month[, year[, format]]]

 * @param  : item   required �޷�â���κ��� ���õ� ��¥�� Text������ ������ EMEdit ������Ʈ Ȥ�� Grid ������Ʈ.

 * @param  : month  optional ���� ��Ÿ���� ���� (1~12).

 * @param  : year   optional �⵵�� ��Ÿ���� 4�ڸ� ����

 * @param  : format optional ��¥�� ǥ���ϴ� ������ ��Ÿ���� ���� ��Ʈ��. item ������Ʈ�� Text������

 *                    ���õǴ� ���� format�� ��Ÿ����. �⺻���� YYYYMMDD �̴�.

 *                    Date ������Ʈ�� format �޼ҵ��� �Ķ���Ϳ� ������ �����Ƿ� ������ ��.

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
// login_sso.jsp ���� �Լ� �߰�
  function checkIsPopUpWindow() {

   // BodyFrame �� top.opener �� ��� NOT_POPUP_WINDOW ��
   // CrossFrame �� BodyFrame �̾��� ��� top.opener ���� �Ұ�

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

 * @desc   : �������� ����ϴ� �����޼��� â�� ����.

 * @sig    : obj

 * @param  : obj required ������ �� ���콺 ������Ʈ(DataSet or Transaction ������Ʈ�� �ϳ�)

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

 * @desc   : ���콺 Grid Object�� ���ε� �Ǿ� �ִ� Dataset�� �����͸� ����(����/��������)�ϰ�,

 * 			 Grid object�� �÷��� ���Ĺ�Ŀ� ���� �̹����� �����ش�. ��(��������),��(��������)

 * <pre>

 *    cfSortGrid(oGrid, SortFd);

 *

 * ��뿹)

 *

 * �����ͼ��� onloadcompleted event�� �߻������� �׸����� name�� sortĮ�� ǥ�ÿ�

 * ������ ���� ���� Į���� ���Ͽ� ����/������������ �����Ͱ� ���ĵȴ�.

 * ���� ���콺 Grid Object�� onclick event�� �̿��ؼ� �����ϴ� ���� onclick event�� �߻� �Ǿ����� �Լ��� ȣ���ϸ�ȴ�.

 *

 * 1. Grid Object ����

 *

 * &lt;object id="oSortGG" classid="CLSID:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49"

 * 	 width="0" height="405" style="position:absolute; left:10; top:89"&gt;

 *   &lt;param name="DataID"    value="oSortGDS"&gt;

 *   &lt;param name="Format"    value='

 *  	&lt;c&gt; id="sortcolumn", name="��Ʈ"&lt;/c&gt; '&gt;

 *

 * 2. �����ͼ��� onloadcompletd event�� �߻������� �Լ��� ȣ���Ѵ�.

 *

 * oSortGG: grid Object id, + : ��������, sortcolumn : �����ϰ��� �ϴ� ������ ���� Į��

 * &lt;script language="javascript" for="oSortGDS" event="OnLoadCompleted()"&gt;

 * 	cfSortGrid(oSortGG, "+sortcolumn");

 * &lt;/script&gt;

 *

 * 3. �Լ� ȣ���� ������ ������ ���� ó�� �ȴ�.

 *

 * "&lt;c&gt; id="sortcolumn", name="��Ʈ"&lt;/c&gt;"  ==> "&lt;c&gt; id="sortcolumn", name="���Ʈ"&lt;/c&gt;"

 * </pre>

 * @sig    : oGrid, SortFd

 * @param  : oGrid required ���� ǥ���� Grid object

 * @param  : SortFd required ���Ĺ�� +(��������),-(��������)�� �����Ϸ��� �ϴ� �����ͼ��� Į�����̵� ���� ǥ���Ѵ�.

 *           +colid ==> colid�� �ش��ϴ� �����͸� ���� �������� �����Ѵ�.

 * @author : ���α�

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



		if ( old_name == '��' || old_name == '��' ){

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

		SortType = '��';

	}

	else {

		SortType = '��';

	}

	oGrid.ColumnProp(ColId,"name") = SortType + Now_name;

}



/**
 * @type   : function
 * @access : public
 * @desc   : ���콺 Grid�� Style�� ������ Style�� �ٲپ��ش�. Style�� ���õ� ������ ������ǥ�ع����� ������ ��.
 * <pre>
 *     cfStyleGrid(oDelivRsltGG, "comn", features);
 * </pre>
 * @sig    : oGrid, styleName[, features]
 * @param  : oGrid     required Grid ������Ʈ
 * @param  : styleName required Grid�� style name. ����� "comn" �� "comnOnTab" �� �ִ�.
 * @param  : features  optional ��Ÿ �Ӽ��� �����ϴ� ��Ʈ��. �Ӽ������� �Ʒ��� ����.
 * <pre>
 *     indWidth  : Grid�� IndWidth �Ӽ� ����.
 *     rowHeight : Grid�� RowHeight �Ӽ� ����.
 *     rowHeight : Grid�� titleHeight �Ӽ� ����.
 *
 *     ��뿹) "indWidth=12,rowHeight=25,titleHeight=30"
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


	// <C> �÷� �Ӽ�
	var CColor;
	var CHeadColor;
	var CHeadBgColor;


	// <FC> �÷� �Ӽ�
	var FCColor;
	var FCBgColor;
	var FCHeadColor;
	var FCHeadBgColor;


	// <G> �÷� �Ӽ�
	var GHeadColor;
	var GHeadBgColor;


	// <FG> �÷� �Ӽ�
	var FGHeadColor;
	var FGHeadBgColor;


	// <X> �÷� �Ӽ�
	var XHeadColor;
	var XHeadBgColor;


	// <FX> �÷� �Ӽ�
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


	// Grid Style �� ����
	switch (styleName) {
        case "comn":
        case "comn2":
			// Grid �Ӽ�
			titleHeight      = titleHeight;
			//titleHeight      = 20;
			fontSize         = "9pt";
			fontFamily       = "����";
			indWidth 		= "0";
			

			// �÷� ���� �Ӽ�
			sumColor         = "#FFFFFF";
			sumBgColor       = "#5c7cac";
			subColor         = "#464646";
			subBgColor       = "#D8D8D8";
			//subpressBgColor  = "#FFFFFF";
			subpressBgColor  = "{decode(currow-tointeger(currow/2)*2,0,'#F5F7FA',1,'#FFFFFF')}"; //"#F0F0F0"


			// �÷��� �Ӽ�
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
			// Grid �Ӽ�
			titleHeight     = titleHeight;
			//titleHeight   = 20;
			fontSize        = "8pt";
			fontFamily      = "����";
			indWidth 		= "0";

			// �÷� ���� �Ӽ�
			sumColor         = "#FFFFFF";
			sumBgColor       = "#5c7cac";
			subColor         = "464646";
			subBgColor       = "#D8D8D8";
			//subpressBgColor  = "#FFFFFF";
			subpressBgColor  = "{decode(currow-tointeger(currow/2)*2,0,'#F5F7FA',1,'#FFFFFF')}"; //"#F0F0F0"

			// �÷��� �Ӽ�
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
            // Grid �Ӽ�
            titleHeight      = 40;
            fontSize         = "9pt";
            fontFamily       = "����";
            indWidth        = "0";
            
            // �÷� ���� �Ӽ�
            sumColor         = "#FFFFFF";
            sumBgColor       = "#5c7cac";
            subColor         = "#464646";
            subBgColor       = "#D8D8D8";
            //subpressBgColor  = "#FFFFFF";
            subpressBgColor  = "{decode(currow-tointeger(currow/2)*2,0,'#F5F7FA',1,'#FFFFFF')}"; //"#F0F0F0"


            // �÷��� �Ӽ�
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
			// Grid �Ӽ�
			titleHeight      = 20;
			fontSize         = "9pt";
			fontFamily       = "����";

			// �÷� ���� �Ӽ�
			sumColor     = "#FFFFFF";
			sumBgColor   = "#DCDDEF";
			subColor     = "464646";
			subBgColor   = "#D8D8D8";
			//subpressBgColor  = "#FFFFFF";
			subpressBgColor  = "{decode(currow-tointeger(currow/2)*2,0,'#F5F7FA',1,'#FFFFFB')}"; //"#F0F0F0"

			// �÷��� �Ӽ�
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
			// Grid �Ӽ�
			titleHeight      = titleHeight;
			fontSize         = "9pt";
			fontFamily       = "����";

			// �÷� ���� �Ӽ�
			sumColor     = "#FFFFFF";
			sumBgColor   = "#DCDDEF";
			subColor     = "464646";
			subBgColor   = "#D8D8D8";
			//subpressBgColor  = "#FFFFFF";
			subpressBgColor  = "{decode(currow-tointeger(currow/2)*2,0,'#F5F7FA',1,'#FFFFFB')}"; //"#F0F0F0"

			// �÷��� �Ӽ�
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


	// Grid �Ӽ� ����
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

	// Grid Format String �� �Ľ��Ͽ� �÷����� Style �� ���õ� �Ӽ��� �����Ѵ�.
	while ((tagMatch = gFormat.match(tagRE)) != null) {
		var style = "";
		var isSupress = false;

		// ����ڰ� ������ �÷� �Ӽ��� ���� ó��
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

		// ����ڰ� ������ �÷� �Ӽ��� ���� ó��
		colAttrData = gFormat.substring(tagMatch.lastIndex, gFormat.indexOf("<", tagMatch.lastIndex));

		if (style == "TITLE") {
			headColor = "#FFFFFF";
			headBgColor = "#8AA1C2";
			headAlign = "Left";
		} else if (style == "REQUIRED") {
			headColor = "#1467E4";
		}

		// Grid�� Format �� Style ���� �Ӽ������� �����Ѵ�.
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

 * @desc   : ���콺 Tab�� Style�� ������ Style�� �ٲپ��ش�.

 * <pre>

 *     cfStyleTab(oDomRegiRecevGTab, "comn");

 * </pre>

 * @sig    : oTab, styleName

 * @param  : oTab required Tab ������Ʈ
 * @param  : styleName required Tab�� style name. ����� "comn" �� "comnOnTab" �� �ִ�.

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

 * @desc   : ���콺 Tree�� Style�� ������ Style�� �ٲپ��ش�.

 * <pre>

 *     cfStyleTreeView(oDomRegiGTree, "comn");

 * </pre>

 * @sig    : oTree, styleName

 * @param  : oTree     required Tree ������Ʈ
 * @param  : styleName required Tree�� style name. ����� "comn" �� "comnOnTab" �� �ִ�.

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



		// </head> �±� ������ ImageDataSet ����

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



	// TreeView���� �ڽĳ�带 ������ �ְ�, Ȯ����� ���� Item���� ����� �̹���Į������ �����Ѵ�.

	oTreeView.ImgCColumn = "ImgC";



	// TreeView���� �ڽĳ�带 ������ ���� ���� Item�� ���� �̹���Į������ �����Ѵ�.

	oTreeView.ImgDColumn = "ImgD";



	// TreeView���� �ڽĳ�带 ������ �ְ�, Ȯ��� Item���� ����� �̹���Į������ �����Ѵ�.

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

 * @desc   : ȭ����� �Է°� ���õ� ������Ʈ�� ���� ��ȿ�� �˻縦 �ǽ��Ѵ�. ��ȿ�� �˻縦 �޴� ������Ʈ���� "validExp" ���

 *           �Ӽ����� �����ؾ� �Ѵ�. "validExp" ��� �Ӽ��� ���� html ��ü���� ���ǵǾ� ���� ���� �Ӽ������� �ٸ� �Ӽ�����

 *           �����ϴ� �Ͱ� ���� ������� �����ϸ� �ڵ����� �ش� ������Ʈ�� �Ӽ����� �νĵȴ�.<br><br>

 *           - �ش� ������Ʈ�� ���� child ������Ʈ������� �˻��Ѵ�. �������, �˻���� ������Ʈ���� &lt;div&gt; �±׷� ���ΰ�

 *             &lt;div&gt; �±��� id�� �Ķ���ͷ� �شٸ� &lt;div&gt; �±׳��� ��� ������Ʈ���� �ڵ����� �˻�ް� �ȴ�. ��,

 *             &lt;table&gt;�ȿ� �Է��ʵ���� &lt;table&gt;�� id�� �Ķ���ͷ� �ָ� �ȴ�.<br><br>

 *           - �Է°��� �հ� ���� ������ ��ȿ�� �˻縦 �ϸ鼭 �ڵ����� trim�ȴ�.

 * <pre>

 *    ��1)

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

 *        &lt;object id="oRecevNo" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F" width="50" <b>validExp="������ȣ:yes:length=6"</b>&gt;

 *            &lt;param name="Format"    value="000000"&gt;

 *        &lt;/object&gt;

 *        ...

 *    &lt;/table&gt;

 *    ...

 * </pre>

 * validExp �Ӽ����� ������ ���Ŀ� �°� �ۼ��Ǿ�� �ϴµ� ������ ������Ʈ�� ������ ���� �� ������ ������.<br>

 * <pre>

 *    1. �Ϲ� ������Ʈ�� ��� (��1 ����)

 *        "item_name:�ʼ�����:valid_expression"

 *

 *        - "item_name"���� �ش� �׸� ���� �̸��� ����Ѵ�.

 *        - "�ʼ�����"���� �ش� ������Ʈ�� �ʼ� �׸����� ���θ� yes|true|1 Ȥ�� no|false|0 Ÿ������ ����Ѵ�.

 *        - "valid_expression" ��  cfValidateValue �Լ��� ������ �����ϱ� �ٶ���.

 *        - �ʼ��׸������� üũ�Ϸ��� "valid_expression" �� ǥ������ ������ �ȴ�.

 *          ��)

 *          &lt;object id="oDelivYmd" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F" width="80" <b>validExp="�������:yes"</b>&gt;

 *              ...

 *			&lt;/object&gt;

 *        - validExp ���� ���Ƿ� ",", ":", "=", "&", ���ڸ� ����ϰ��� �Ѵٸ� "\\,", "\\:", "\\=", "\\&" ��� ǥ���ؾ� �Ѵ�.<br>

 *

 *

 *    2. ���콺 Grid ������Ʈ�� ���

 *        "column_id:item_name:�ʼ�����[:valid_expression[:key]][,column_name:item_name:�ʼ�����[:valid_expression[:key]]]..."

 *

 *        - column_id ����  Grid�� ����� DataSet�� ���� �÷� id �� �����ش�.

 *

 *        - <font color=blue><b>dataName</b></font> �̶�� �Ӽ��� ����� �־�� �Ѵ�. dataName�� �ش� DataSet

 *          �� ǥ���ϴ� �̸��� ����� �ָ� �ȴ�.

 *

 *        - <font color=blue><b>validFeatures</b></font> ��� �Ӽ��� �ʿ信 ���� ����� �־�� �Ѵ�. validFeatures�� Grid Validation

 *          ����ÿ� �ʿ��� ���������� ����� �ִ� �Ӽ����ν� ����� ���� ������ �⺻ ���������� �ڵ����� ����ȴ�.

 *          ǥ���ϴ� ������ <b>validFeatures="�������Ǹ�1=�������ǰ�1,�������Ǹ�2=�������ǰ�2, ... �������Ǹ�n=�������ǰ�n"</b> �̴�.

 *          ���� ��밡���� ���������� ������ ����.

 *

 *          ignoreStatus : ��������� ���� Row �� ���ؼ��� validation�� �������� ����. (yes|true|1 or no|false|0)

 *

 *        ��)

 *

 *        cfValidate([oDomRegiRecevGG]);

 *        ...

 *        &ltobject id="oDomRegiRecevGG" classid="CLSID:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49"

 *           width="174" height="233" style="position:absolute; left:10; top:73;" <b>dataName="��ް������Ʈ"</b> <b>validFeatures="ignoreStatus=yes"</b>

 *         <b>validExp="regiNo:����ȣ:yes:length=13:key,

 *                  sendPrsnZipNo:�߼��ο����ȣ:yes:length=6,

 *                  recPrsnZipNo:�����ο����ȣ:yes:length=6

 *                 "</b>

 *        &gt;

 *

 *        - ���� item_name�� ������� �ʾ��� ��쿡�� Grid�� column_id�� �ش��ϴ� �÷��� �÷������� �ڵ����� ��ü�ȴ�.

 *          ��) validExp="regiNo::yes:length=13, ..."

 *

 *        - ���� �÷��� key�÷��� ��쿡�� ���� "key" ��� ����� �ش�. "key" ��� ����� �ָ� �ٸ� Row�� �����Ͱ� �ߺ��Ǿ��� ��

 *          ������ �߻���Ų��. key�÷��� ������ ��쿡�� key�÷����� ��� �ϳ��� key�� �ν��ϱ� ������ key�÷��߿� �ϳ���

 *          �ߺ��� ���� �ʾƵ� ��ü�� �ߺ����� ���� ������ ó���ȴ�. key�÷����� ?Ⱦ�? ó������ �ʰ� key�÷����� ��������

 *          �ߺ�üũ�� ���� ��쿡�� "singleKey" ��� ����ϸ� �ȴ�.

 *          ��, key�� ����� �� ��쿡�� valid_expression �� �ݵ�� ������ �ְ� ������ �� ������ ������

 *          ':' �� �����ؾ� �Ѵ�.

 *          ��) validExp="regiNo:����ȣ:yes::key, ...

 *

 *        - �������� 1�� ���� ����.

 * </pre>

 * @sig    : objArr

 * @param  : objectArr required ��ȿ���˻縦 �ϰ��� �ϴ� ������Ʈ���� Array.

 * @return : boolean. ��ȿ�� ����.

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

 * @desc   : ���콺�� html �� ��� ������Ʈ�� ���� ��ȿ�� �˻縦 �Ѵ�.

 * @sig    : oElement

 * @param  : oElement required �˻� ��� Element.

 * @return : boolean. ��ȿ�� ����.

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

 * @desc   : ���콺 ������Ʈ �߿��� DataSet�� ������ ��� ������Ʈ�� html�� ��� ������Ʈ�� ���� ��ȿ�� �˻縦 �Ѵ�.

 * @sig    : oElement

 * @param  : oElement required �˻� ��� Element.

 * @return : boolean. ��ȿ�� ����.

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

			oElement.value = oElement.value.trim();  // element�� ���� trim �����ش�.

			value = oElement.value;

			break;



		case "OBJECT":

			switch (oElement.attributes.classid.nodeValue.toUpperCase()) {

				case "CLSID:FD4C6571-DD20-11D2-973D-00104B15E56F": // CodeCombo Component

				case "CLSID:14DA1FE5-438E-4E2C-959D-5BF03F63EA9C": // CodeCombo2 Component

				case "CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0": // Radio Component

					oElement.CodeValue = (oElement.CodeValue == null) ? null : oElement.CodeValue.trim();  // element�� ���� trim �����ش�.

					value = oElement.CodeValue;

                    break;



                case "CLSID:91B0A4F0-3206-4564-9BB4-AF9055DEF8A1": // TextArea Component

				case "CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03": // InputFile Component

				case "CLSID:E6876E99-7C28-43AD-9088-315DC302C05F": // EMedit Component

					oElement.Text = (oElement.Text == null) ? null : oElement.Text.trim();  // element�� ���� trim �����ش�.

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

 * @desc   : ���콺�� Grid�� ���� ��ȿ�� �˻縦 �Ѵ�. ��ȿ�� �˻縦 ���ؼ��� Grid�� DataId�� ������ DataSet�� validExp �Ӽ���

 *           �����Ǿ� �־�� �Ѵ�. ��������� cfValidate �Լ��� ���� ������ �����ϱ� �ٶ���. (���������δ� Grid�� �˻��ϴ� ���� �ƴ϶�

 *           Grid�� DataId�� ������ DataSet�� ���� ��ȿ�� �˻��̴�.)

 * @sig    : oGrid[, row[, colId]]

 * @param  : oGrid required �˻� ��� Grid.

 * @param  : row   optional �˻��ϰ��� �ϴ� row ��ȣ

 * @param  : colId optional �˻��ϰ��� �ϴ� �÷��� id

 * @return : boolean. ��ȿ�� ����.

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

		alert(new coMessage().getMsg("@�� @��° �����Ϳ��� ", [dataName, String(gridValidExp.errRow)]) +

		      new coMessage().getMsg(gridValidExp.errMsg, [gridValidExp.errItemName])

		     );

//		oDataSet.RowPosition = gridValidExp.errRow;  // �̼��� �Ǵٽ� CanRowPosChange �̺�Ʈ�� �߻��Ͽ� ���ѷ����� ������.

        if (oGrid.MultiRowSelect == false) {  // Grid�� MultiRowSelect �Ӽ��� false�� ��쿡�� RowMark, MarkRows��

        	oGrid.MultiRowSelect = true;      // ������ row�� ����� Marking�� ���� ���Ѵ�. ����...

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

 * @desc   : ������� �Է°��� Byte�� ȯ��� �ִ���̸� ���� ��� �Է��� �ȵǵ��� �ϴ� �Լ�. <br>

 *           ��Ÿ���Ե� Windows XP ȯ�濡���� �ѱۿ� ���� Ű�̺�Ʈ�� �߻����� �ʾƼ� �������� �ʴ´�.<br>

 *           ������Ʈ ����� onkeydown �̺�Ʈ�� ������ ���� ����� �־�߸� �Ѵ�.

 * <pre>

 *     onkeydown="cfValidateMaxByteLength(this, max_byte_length)"

 *     (���⼭ max_byte_length �ڸ����� Byte�� ȯ��� �ִ���̸� ���ڷ� �����ش�.)

 *

 *     ��)

 *     &lt;input type="text" size="10" onkeydown="cfValidateMaxByteLength(this, 10)"&gt;

 * </pre>

 *           ����� html�� text input, textarea �� ���콺�� EMEdit ���� ����ȴ�.

 * @sig    : oElement, length

 * @param  : oElement required �Է��ʵ� ��ü
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

       // �ϼ��ѱ� : 0xAC00 <= c && c <= 0xD7A3

       // ���� : 0x3131 <= c

       // ���� : c <= 0x318E

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

 * @desc   : Ư�� ���� ���� ��ȿ���˻縦 �����Ѵ�.

 * <pre>

 *     cfValidateValue(50, "minNumber=100");

 * </pre>

 * ���� ��� 50�� �ּҰ� 100�� ���� �����Ƿ� false�� ���ϵȴ�.<br>

 * ��ȿ�� �˻縦 �����ϱ� ���ؼ��� �˻������� ����ؾ� �ϴµ�

 * �˻������� 'valid expression' �̶�� �Ҹ���� String ������ ǥ���ȴ�. valid expression�� ���� ǥ��������

 * ������ ����.

 * <pre>

 *  	validator_name=valid_value[&validator_name=valid_value]..

 *

 *  	��) "minNumber=100"

 * </pre>

 * - validator_name�� �˻������� �ǹ��ϸ� valid_value�� ���� ���� �ȴ�. <br>

 * - �˻��׸��� �ϳ� �̻��� �� ������ �˻��׸񰣿��� "&" ���ڷ� �����Ͽ� �ʿ��� ��ŭ �����ϸ� �ȴ�. <br>

 * - valid_value�� ",", ":", "=", "&", ���ڸ� ����ϰ��� �Ѵٸ� "\\,", "\\:", "\\=", "\\&" ��� ǥ���ؾ� �Ѵ�.<br>

 * - ���� �������� "minNumber" (�ּҰ�)��� ��ȿ�� �˻��׸��� ����Ͽ��� minNumber ������ ���ذ����� "100" �� �����Ǿ� �ִ�.

 * ���� 100���� ���� ���� �Է����� ���� 100 �̻��� ���� �Է��϶�� alert box�� �߰� �ȴ�.

 * - validator_name�� �̸� ���ǵǾ� �ִ� �͸� ����� �� �ְ� �� �˻��������� valid_value�� ���µ� �ٸ���.(valid_value�� ���� �͵� �ִ�.)

 * ���� ���ǵ� �˻������� ������ ����.

 * <br><br>

 * <table border=1 style="border-collapse:collapse; border-width:1pt; border-style:solid; border-color:000000;">

 * 		<tr>

 * 			<td align="center" bgcolor="#CCCCFFF">�˻�����</td>

 * 			<td align="center" bgcolor="#CCCCFFF">���ذ� ����</td>

 * 			<td align="center" bgcolor="#CCCCFFF">����</td>

 * 			<td align="center" bgcolor="#CCCCFFF">��</td>

 * 		</tr>

 * 		<tr>

 * 			<td>length</td>

 * 			<td>0���� ū ����</td>

 * 			<td>�ڸ��� �˻�. �Է°��� �ڸ����� ���ذ��� ��ġ�ϴ����� �˻��Ѵ�. �Ϲ������� HTML������ �ѱ�, ����, ���� ��� 1�ڸ��� �νĵȴ�.</td>

 * 			<td>length=6</td>

 * 		</tr>

 * 		<tr>

 * 			<td>byteLength</td>

 * 			<td>0���� ū ����</td>

 * 			<td>Byte�� ȯ��� �ڸ��� �˻�. �Է°��� �ڸ����� byte�� ȯ���Ͽ� �ڸ����� ���ذ��� ��ġ�ϴ����� �˻��Ѵ�.(���� �� ������ 1byte, �ѱ��� 2byte�̴�.)</td>

 * 			<td>byteLength=6</td>

 * 		</tr>

 * 		<tr>

 * 			<td>minLength</td>

 * 			<td>0���� ū ����</td>

 * 			<td>�ּ��ڸ��� �˻�. �Է°��� �ڸ����� ���ذ� �̻��� �Ǵ����� �˻��Ѵ�.</td>

 * 			<td>minLength=6</td>

 * 		</tr>

 * 		<tr>

 * 			<td>minByteLength</td>

 * 			<td>0���� ū ����</td>

 * 			<td>Byte�� ȯ��� �ּ��ڸ��� �˻�. �Է°��� �ڸ����� byte�� ȯ���Ͽ� �ڸ����� ���ذ� �̻��� �Ǵ����� �˻��Ѵ�.(���� �� ������ 1byte, �ѱ��� 2byte�̴�.)</td>

 * 			<td>minByteLength=6</td>

 * 		</tr>

 * 		<tr>

 * 			<td>maxLength</td>

 * 			<td>0���� ū ����</td>

 * 			<td>�ִ��ڸ��� �˻�. �Է°��� �ڸ����� ���ذ� ���ϰ� �Ǵ����� �˻��Ѵ�.</td>

 * 			<td>maxLength=6</td>

 * 		</tr>

 * 		<tr>

 * 			<td>maxByteLength</td>

 * 			<td>0���� ū ����</td>

 * 			<td>Byte�� ȯ��� �ִ��ڸ��� �˻�. �Է°��� �ڸ����� byte�� ȯ���Ͽ� �ڸ����� ���ذ� ���ϰ� �Ǵ����� �˻��Ѵ�.(���� �� ������ 1byte, �ѱ��� 2byte�̴�.)</td>

 * 			<td>maxByteLength=6</td>

 * 		</tr>

 * 		<tr>

 * 			<td>number</td>

 * 			<td>None or decimal format string. decimal format string ������ "(�����ڸ���.�Ҽ��ڸ���)" �̴�.</td>

 * 			<td>���ڰ˻�. �Է°��� ���������� �˻��Ѵ�. ���� �Է°��� ���� decimal format�� �����Ͽ��� ���� format�� �´����� �˻��Ѵ�.</td>

 * 			<td>number, number=(5.2)</td>

 * 		</tr>

 * 		<tr>

 * 			<td>minNumber</td>

 * 			<td>����</td>

 * 			<td>�ּҼ� �˻�. �Է°��� �ּ��� ���ذ� �̻��� �Ǵ����� �˻��Ѵ�.</td>

 * 			<td>minNumber=100</td>

 * 		</tr>

 * 		<tr>

 * 			<td>maxNumber</td>

 * 			<td>����</td>

 * 			<td>�ִ�� �˻�. �Է°��� ���ذ� ���������� �˻��Ѵ�.</td>

 * 			<td>maxNumber=300</td>

 * 		</tr>

 * 		<tr>

 * 			<td>inNumber</td>

 * 			<td>"����~����" �������� ǥ��.</td>

 * 			<td>������ �˻�. �Է°��� ������ �Ǵ� �� ���� ���ų� Ȥ�� �� �� ���̿� �����ϴ� �������� �˻��Ѵ�.</td>

 * 			<td>inNumber=100~300</td>

 * 		</tr>

 * 		<tr>

 * 			<td>minDate</td>

 * 			<td>YYYYMMDD ������ ��¥ ��Ʈ��.</td>

 * 			<td>�ּҳ�¥ �˻�. �Էµ� ��¥�� ���س�¥�̰ų� ���س�¥ ���������� �˻��Ѵ�.</td>

 * 			<td>minDate=20020305</td>

 * 		</tr>

 * 		<tr>

 * 			<td>maxDate</td>

 * 			<td>YYYYMMDD ������ ��¥ ��Ʈ��. ��) maxDate=20020305</td>

 * 			<td>�ִ볯¥ �˻�. �Էµ� ��¥�� ���س�¥�̰ų� ���س�¥ ���������� �˻��Ѵ�.</td>

 * 			<td>maxDate=20020305</td>

 * 		</tr>

 * 		<tr>

 * 			<td>format</td>

 * 			<td>format character��� �ٸ� ���ڵ��� ������ ��Ʈ��.<br>

 * 				<table>

 * 					<tr>

 * 						<td><b>format character</b></td>

 * 						<td><b>desc</b></td>

 * 					</tr>

 * 					<tr>

 * 						<td>#</td>

 * 						<td>���ڿ� ����</td>

 * 					</tr>

 * 					<tr>

 * 						<td>h, H</td>

 * 						<td>�ѱ�(H�� ��������)</td>

 * 					</tr>

 * 					<tr>

 * 						<td>A, Z</td>

 * 						<td>����(Z�� ��������)</td>

 * 					</tr>

 * 					<tr>

 * 						<td>0, 9</td>

 * 						<td>���� (9�� ��������)</td>

 * 					</tr>

 * 				</table>

 * 			</td>

 * 			<td>���� �˻�. �Էµ� ���� ������ ���Ŀ� �´����� �˻��Ѵ�.</td>

 * 			<td>format=000-000</td>

 * 		</tr>

 * 		<tr>

 * 			<td>ssn</td>

 * 			<td>�ֹε�Ϲ�ȣ 13�ڸ�</td>

 * 			<td>�ֹε�Ϲ�ȣ �˻�. �Է��� �ֹε�Ϲ�ȣ�� ��ȿ������ �˻��Ѵ�.</td>

 * 			<td>ssn</td>

 * 		</tr>

 * 		<tr>

 * 			<td>csn</td>

 * 			<td>����ڵ�Ϲ�ȣ 10�ڸ�</td>

 * 			<td>����ڵ�Ϲ�ȣ �˻�. �Է��� ����ڵ�Ϲ�ȣ�� ��ȿ������ �˻��Ѵ�.

 *              (��, 2019009930)

 *          </td>

 * 			<td>csn</td>

 * 		</tr>

 * 		<tr>

 * 			<td>filterIn</td>

 * 			<td>���͸��Ͽ� ����� �ϴ� ��Ʈ���� ";"���ڸ� �����ڷ� ����Ͽ� �����Ѵ�.(�� ";" ���ڸ� ���͸��ϰ� ���� �� "\;"��� ǥ���Ѵ�.

 *          </td>

 * 			<td>�Է°��� ������ ���ڳ� ��Ʈ�� �̿ܿ� �ٸ� ���� �ִ����� �˻��Ѵ�. �ϳ��� ���ٸ� ��ȿ�ϴ�.</td>

 * 			<td>filter=%;<;GAUCE;\\;;haha<br>(�Է°� ���� "%","<","GAUCE",";","haha" �߿� �ϳ��� �ִ��� �˻��Ѵ�.)

 *          </td>

 * 		</tr>

 * 		<tr>

 * 			<td>filterOut</td>

 * 			<td>���͸��Ͽ� �ɷ����� ���� ��Ʈ���� ";"���ڸ� �����ڷ� ����Ͽ� �����Ѵ�.(�� ";" ���ڸ� ���͸��ϰ� ���� �� "\;"��� ǥ���Ѵ�.

 *          </td>

 * 			<td>�Է°��� ������ ���ڳ� ��Ʈ���� �ִ����� �˻��Ѵ�. �ϳ��� ���ٸ� ��ȿ�ϴ�.</td>

 * 			<td>filter=%;<;GAUCE;\\;;haha<br>(�Է°� ���� "%","<","GAUCE",";","haha" �߿� �ϳ��� �ִ��� �˻��Ѵ�.)

 *          </td>

 * 		</tr>

 * 		<tr>

 * 			<td>email</td>

 * 			<td>�̸��� �ּ�</td>

 * 			<td>�Է��� �����ּҰ� ��ȿ�� �̸��� ���������� �˻��Ѵ�.</td>

 * 			<td>email</td>

 * 		</tr>

 * 		<tr>

 * 			<td>date</td>

 * 			<td>format character�� �������� �̷���� ���ڿ� ���� ���� ��Ʈ��.<br>

 * 				<table>

 * 					<tr>

 * 						<td><b>format character</b></td>

 * 						<td><b>desc</b></td>

 * 					</tr>

 * 					<tr>

 * 						<td>YYYY</td>

 * 						<td>4�ڸ� �⵵</td>

 * 					</tr>

 * 					<tr>

 * 						<td>YY</td>

 * 						<td>2�ڸ� �⵵. 2000�� ����</td>

 * 					</tr>

 * 					<tr>

 * 						<td>MM</td>

 * 						<td>2�ڸ� ������ ��</td>

 * 					</tr>

 * 					<tr>

 * 						<td>DD</td>

 * 						<td>2�ڸ� ������ ��</td>

 * 					</tr>

 * 					<tr>

 * 						<td>hh</td>

 * 						<td>2�ڸ� ������ �ð�. 12�� ����</td>

 * 					</tr>

 * 					<tr>

 * 						<td>HH</td>

 * 						<td>2�ڸ� ������ �ð�. 24�� ���� </td>

 * 					</tr>

 * 					<tr>

 * 						<td>mm</td>

 * 						<td>2�ڸ� ������ ��</td>

 * 					</tr>

 * 					<tr>

 * 						<td>ss</td>

 * 						<td>2�ڸ� ������ ��</td>

 * 					</tr>

 * 				</table>

 * 			</td>

 * 			<td>��¥ �˻�. �Էµ� ��Ʈ������ ��¥�� ȯ���Ͽ� ��ȿ�� ��¥������ �˻��Ѵ�.</td>

 * 			<td>date=YYYYMMDD  �� �� �Է°��� '20020328' �� ��� -> ��ȿ<br>

 *              date=YYYYMMDD  �� �� �Է°��� '20020230' �� ��� -> ����<br>

 *              date=Today is YY-MM-DD' �� �� �Է°��� 'Today is 02-03-28' �� ��� -> ��ȿ<br><br>

 * 				����) format���ڰ� �ߺ��ؼ� �������� ó�� ���� ���ڿ� ���ؼ��� format���ڷ� �νĵȴ�.

 *                    YYYY�� YY, hh�� HH �� �ߺ����� ����. ��¥�� ��,���� ������ ���� ��Ȯ�� üũ�ϰ�

 *                    ���� ��, ���� ���ٸ� 1 ~ 31 ���������� üũ�Ѵ�.

 * 			</td>

 * 		</tr>

 * </table>

 * @sig    : value, validExp

 * @param  : value    required �˻� ����� �Ǵ� ��.

 * @param  : validExp required ����ڰ� ������ Valid Expression String.

 * @return : boolean. ��ȿ�� ����.

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

 * @desc   : Grid�� ���õ� Row���� ����Ѵ�.

 * <pre>

 *     cfUndoGridRows(oDomRegiRecevGG);

 * </pre>

 * ���� ������ oDomRegiRecevGG�� ���� ���õ� row���� ��� ��ҵȴ�.<br><br>

 * <font color=red>

 * ������ cfUndoGridRows �Լ��� �Ķ���ʹ� DataSet�̾����� �Ķ���Ͱ� Grid�� �ٲ����.

 * ������ ������ �Ķ���͸� DataSet���� ����� ��쿡�� ������� ���۵ǵ��� �ۼ��Ǿ���.

 * </font>

 * @sig    : oGrid

 * @param  : oGrid required Grid ������Ʈ

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



//---------------------------------------- ���� ��ü���� ------------------------------------------------------------------------------//



///////////////////////////// coMessage /////////////////////////////

/**

 * @type   : object

 * @access : private

 * @desc   : �޼����� �����ϴ� ��ü�̴�.

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

 * @desc   : ����޼����� ���ǵ� �޼����� ġȯ�Ͽ� �˷��ش�.

 * @sig    : message[, paramArray]

 * @param  : message    required common.js�� ���� �޼��� ������ ����� �޼��� ID

 * @param  : paramArray optional �޼������� '@' ���ڿ� ġȯ�� ��Ʈ�� Array. (Array�� index��

 *           �޼��� ���� '@' ������ ������ ��ġ�Ѵ�.)

 * @return : ġȯ�� �޼��� ��Ʈ��

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

 * @desc   : Grid �� ����� �÷������� ����ִ� ��ü�̴�.

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

 * @desc   : �÷��� Ư�� �Ӽ��� ���ǵǾ� �ִ��� �˷��ش�.

 * @sig    : attrName

 * @param  : attrName required �Ӽ���

 * @return : �Ӽ� ���翩��

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

 * @desc   : �÷��� ���ο� �Ӽ��� �߰��Ѵ�.

 * @sig    : attrName, attrValue

 * @param  : attrName required �Ӽ���

 * @param  : attrValue required �Ӽ���

 * @return : �Ӽ� ���翩��

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

 * @desc   : �÷��� Ư�� �Ӽ����� �˷��ش�.

 * @sig    : attrName

 * @param  : attrName required �Ӽ���

 * @return : �Ӽ���

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

 * @desc   : Grid Format�� �Ľ��� �� ������ �����Ѵ�.

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

 * @desc   : �Ľ��Ѵ�.

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

 * @desc   : Grid�� ����� �÷��� �߿��� Ư�� colid�� ���� �÷��� �����ϴ����� �˷��ش�.

 * @sig    : colId

 * @param  : colId required �Ӽ���

 * @return : �÷� ���翩��

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

 * @desc   : String parameter �� ���� name�� value �ֵ��� ���� ��ü

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

 * @desc   : name�� �´� �Ķ���Ͱ��� �����Ѵ�.

 * @sig    : name

 * @param  : name required map�� name���� ����� ��

 * @return : �Ķ���Ͱ�

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

 * @desc   : ���ο� map�� �߰��Ѵ�. ���� name�� ������ ��� overwrite�Ѵ�.

 * @sig    : name, value

 * @param  : name  required map�� name�� ����� ��

 * @param  : value required map�� value�� ����� ��

 * @return : �Ķ���Ͱ�

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

 * @desc   : ������ index�� �ִ� map�� name�� �˷��ش�.

 * @sig    : index

 * @param  : index - map�� index

 * @return : name

 */

function coMap_getNameAt(index) {

	return this.names[index];

}



/**

 * @type   : method

 * @access : public

 * @object : coMap

 * @desc   : ������ index�� �ִ� map�� value�� �˷��ش�.

 * @sig    : index

 * @param  : index required map�� index

 * @return : value

 */

function coMap_getValueAt(index) {

	return this.values[index];

}



/**

 * @type   : method

 * @access : public

 * @object : coMap

 * @desc   : map�� name-value ���� ������ �˷��ش�.

 * @return : name-value ���� ����

 */

function coMap_size() {

	return this.count;

}



/**

 * @type   : method

 * @access : public

 * @object : coMap

 * @desc   : map ���� name ������ String���� ȯ���Ͽ� �ִ���̸� �˷��ش�.

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

 * @desc   : String parameter �� ���� name�� value �ֵ��� ���� ��ü

 * @author : GAUCE

 */

function coParameterMap() {

	// fields



	/**

	 * @type   : field

	 * @access : private

	 * @object : coParameterMap

	 * @desc   : �Ķ���� �̸��� ����ִ� array

	 */

	this.names = new Array();



	/**

	 * @type   : field

	 * @access : private

	 * @object : coParameterMap

	 * @desc   : �Ķ���� ���� ����ִ� array

	 */

	this.values = new Array();



	/**

	 * @type   : field

	 * @access : private

	 * @object : coParameterMap

	 * @desc   : �Ķ������ ����

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

 * @desc   : name�� �´� �Ķ���Ͱ��� �����Ѵ�.

 * @sig    : name

 * @param  : name required map�� name���� ����� ��

 * @return : �Ķ���Ͱ�

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

 * @desc   : ���ο� map�� �߰��Ѵ�. ���� name�� ������ ��� overwrite�Ѵ�.

 * @sig    : name, value

 * @param  : name  required map�� name�� ����� ��

 * @param  : value required map�� value�� ����� ��

 * @return : �Ķ���Ͱ�

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

 * @desc   : ������ index�� �ִ� map�� name�� �˷��ش�.

 * @sig    : index

 * @param  : index required map�� index

 * @return : name

 */

function coParameterMap_getNameAt(index) {

	return this.names[index];

}



/**

 * @type   : method

 * @access : public

 * @object : coParameterMap

 * @desc   : ������ index�� �ִ� map�� value�� �˷��ش�.

 * @sig    : index

 * @param  : index required map�� index

 * @return : value

 */

function coParameterMap_getValueAt(index) {

	return this.values[index];

}



/**

 * @type   : method

 * @access : public

 * @object : coParameterMap

 * @desc   : map�� name-value ���� ������ �˷��ش�.

 * @return : name-value ���� ����

 */

function coParameterMap_size() {

	return this.count;

}



/**

 * @type   : method

 * @access : public

 * @object : coParameterMap

 * @desc   : map ���� name ������ String���� ȯ���Ͽ� �ִ���̸� �˷��ش�.

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

 * @desc   : map ���� value ������ String���� ȯ���Ͽ� �ִ���̸� �˷��ش�.

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



//-------------------------- ��ȿ�� �˻縦 ���� ��ü ���� -----------------------------//

/*

 * @Validator ��ü�� ����

 *   - �Ӽ� : exception,   -> validity�� sub�Ӽ��̴�. validity�� true�� exception�� ������ false�̰�

 *                            validity�� false�� ��� false�� ������ exception���� ���θ� �˷��ش�.

 *                            exception�� ����� �Է¿� ���� ���� validation���� ������ ������ �ǹ��Ѵ�.

 *                            true/false �� �ϳ�.

 *            message,     -> �����޼����� ��� �ִ�.

 *            validity,    -> ��ȿ���˻����� ��� �ִ�. true/false �� �ϳ�.

 *            value        -> ��ȿ�� �˻� ��� ��.

 *

 *   - �޼ҵ� : validate() -> ��ȿ�� �˻縦 �����Ѵ�.

 *                            ��ȿ�� ���, validity�� true���ϰ� true�� return�ϰ�

 *                            ��ȿ���� ���� ���,  validity�� false���ϰ� false�� return�ϰ�

 *                            message�� �����޼����� ����Ѵ�.

 *                            exception�� ���� exception�� true�� �ϰ� message�� �޼����� ����Ѵ�.

 *

 *   - �߰��� ���� :

 *     1) validator��ü�� �����Ѵ�.

 *     2) covValidExp ��ü�� getValidators �޼ҵ忡 validator��ü�� ����Ѵ�.

 */



///////////////////////////// covValueValidExp /////////////////////////////

/**

 * @type   : object

 * @access : private

 * @desc   : ��ȿ�� �˻翡 ���� ǥ��(expression)�� ��üȭ �Ͽ���.

 *             - expression ����<br>

 *               �׸��̸�:�ʼ��׸񿩺�:��ȿ���׸�<br>

 *               ��) "������ȣ:yes:length=6"

 *             - ��ȿ�� �׸� ����

 *               ��ȿ���׸��=��ȿ��[&��ȿ���׸��=��ȿ��]..

 *               ��) "length=13&ssn"

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

 * @desc   : �ʱ�ȭ�� �����Ѵ�.

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

 * @desc   : covValidExp ��ü�� parse �޼ҵ�.

 *           valid expression�� parsing�Ѵ�.

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

		validItem.value = validItemPair[1];  // parsedExp[1] �� �������� ���� ���� ������ �ڹٽ�ũ��Ʈ������

		this.validItems[i] = validItem;      // �̷� ��� "undefined" ��� ���� �����Ѵ�.

	}

}



/**

 * @type   : method

 * @access : private

 * @object : covValueValidExp

 * @desc   : validation�� �����Ѵ�.

 * @sig    : value

 * @param  : value required �˻���

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

 * @desc   : ��ȿ�� �˻翡 ���� ǥ��(expression)�� ��üȭ �Ͽ���.

 *             - expression ����<br>

 *               �׸��̸�:�ʼ��׸񿩺�:��ȿ���׸�<br>

 *               ��) "������ȣ:yes:length=6"

 *             - ��ȿ�� �׸� ����

 *               ��ȿ���׸��=��ȿ��[&��ȿ���׸��=��ȿ��]..

 *               ��) "length=13&ssn"

 * @sig    : expression, itemName

 * @param  : expression required valid expression string.

 * @param  : itemName   required �����۸�

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

 * @desc   : valid expression�� parsing�Ѵ�.

 * @sig    : expression, itemName

 * @param  : expression required valid expression string.

 * @param  : itemName   required �����۸�

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

 * @desc   : validation�� �����Ѵ�.

 * @sig    : value

 * @param  : value required �˻��� ��

 */

function covItemValidExp_validate(value) {

	// ǥ���Ŀ� �ʼ��׸��(�����۸�, �ʼ�����)�� ������� ���� ���� ǥ������ ���ٰ� ����.

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

 * @desc   : Grid�� �÷� ��ȿ�� �˻� ǥ����

 * @sig    : expression, oGrid

 * @param  : expression required valid expression string.

 * @param  : oGrid      required �˻��� Grid ������Ʈ

 * @author : GAUCE

 */

function covColumnValidExp(expression, oGrid) {

    // data;

    this.colId;

    this.errMsg = "";

    this.errRow = -1;

    this.errItemName = "";

    this.itemValidExp;

    this.property = "NORMAL";  // NORMAL, KEY, SINGLEKEY �Ӽ��� �ִ�.



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

 * @desc   : valid expression�� parsing�Ѵ�.

 * @sig    : expression, oGrid

 * @param  : expression required valid expression string.

 * @param  : oGrid      required �˻��� Grid ������Ʈ

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

 * @desc   : validation�� �����Ѵ�.

 * @sig    : oDataSet, row

 * @param  : oDataSet required �˻��� DataSet

 * @param  : row required �˻��� DataSet�� Ư�� row ��ȣ

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

                 null : oDataSet.NameString(i, this.colId).trim();  // DataSet�� data�� trim ��Ų��.



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

 * @desc   : Grid�� ���� ��ȿ���˻� ǥ����

 * @sig    : oGrid

 * @param  : oGrid required �˻��� Grid

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

 * @desc   : valid expression�� parsing�Ѵ�.

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

 * @desc   : validation�� �����Ѵ�.

 * @sig    : [row[, colId[, ignoreStatus]]]

 * @param  : row optional �˻��� Grid�� Ư�� row ��ȣ

 * @param  : colId optional �˻��� Grid�� Ư�� �÷��� id

 * @param  : ignoreStatus optional Grid �˻�� row status�� ������� ��� �˻��� �������� ����.

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



	// Ű�÷� ����

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



	// �ߺ�Ű üũ

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



				// �Ϲ�Ű�÷� �˻�.

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

							this.errRow = row;  // row�� �����Ͽ��� ���� �ش� row�� ���� error�� ����

						} else {

							this.errRow = j; // row������ ������ �ߺ��� �ΰ��� �������� ������ ���߿� �ִ� row�� error�� ����

						}



						for (var k = 0; k < keyColValidExps.length; k++) {

							this.errItemName = this.errItemName + keyColValidExps[k].itemValidExp.itemName + ", ";

						}



						this.errItemName = this.errItemName.substring(0, this.errItemName.lastIndexOf(","));

						return false;

					}

				}



				// �̱�Ű�÷� �˻�.

				for (var k = 0; k < singleKeyColValidExps.length; k++) {

					if (oDataSet.NameValue(i, singleKeyColValidExps[k].colId) ==

					    oDataSet.NameValue(j, singleKeyColValidExps[k].colId)

					   ) {

						this.errMsg = cfGetMsg(MSG_COM_ERR_032, ["@"]);



						if (row != null) {

							this.errRow = row;  // row�� �����Ͽ��� ���� �ش� row�� ���� error�� ����

						} else {

							this.errRow = j; // row������ ������ �ߺ��� �ΰ��� �������� ������ ���߿� �ִ� row�� error�� ����

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



	// validation ����

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

 * @desc   : 'length' �׸� ���� validator. ���� ������ ���̸� ������ �ִ��� �˻��Ѵ�.

 * @param  : length required ��ȿ�� ���ر���.

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

 * @desc   : validation�� �����Ѵ�.

 * @sig    : value

 * @param  : value   required ��ȿ�� �˻� ���.

 * @return : boolean. ��ȿ�� ����.

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

 * @desc   : 'byteLength' �׸� ���� validator. ���� ������ byte������ ���̸� ������ �ִ��� �˻��Ѵ�.

 * @param  : length required ��ȿ�� ���ر���.

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

 * @desc   : validation�� �����Ѵ�.

 * @sig    : value

 * @param  : value   required ��ȿ�� �˻� ���.

 * @return : boolean. ��ȿ�� ����.

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

 * @desc   : 'minLength' �׸� ���� validator. ���� ������ ���� �̻������� �˻��Ѵ�.

 * @sig    : length

 * @param  : length required ��ȿ�� ���ر���.

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

 * @desc   : validation�� �����Ѵ�.

 * @sig    : value

 * @param  : value   required ��ȿ�� �˻� ���.

 * @return : boolean. ��ȿ�� ����.

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

 * @desc   : 'minByteLength' �׸� ���� validator. ���� ������ byte������ ���� �̻������� �˻��Ѵ�.

 * @sig    : length

 * @param  : length required ��ȿ�� ���ر���.

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

 * @desc   : validation�� �����Ѵ�.

 * @sig    : value

 * @param  : value   required ��ȿ�� �˻� ���.

 * @return : boolean. ��ȿ�� ����.

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

 * @desc   : 'maxLength' �׸� ���� validator. ���� ������ ���� �̻������� �˻��Ѵ�.

 * @sig    : length

 * @param  : length required ��ȿ�� ���ر���.

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

 * @desc   : validation�� �����Ѵ�.

 * @sig    : value

 * @param  : value   required ��ȿ�� �˻� ���.

 * @return : boolean. ��ȿ�� ����.

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

 * @desc   : 'maxByteLength' �׸� ���� validator. ���� ������ byte������ ���� ���������� �˻��Ѵ�.

 * @sig    : length

 * @param  : length required ��ȿ�� ���ر���.

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

 * @desc   : validation�� �����Ѵ�.

 * @sig    : value

 * @param  : value   required ��ȿ�� �˻� ���.

 * @return : boolean. ��ȿ�� ����.

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

 * @desc   : 'number' �׸� ���� validator. ���� ���������� �˻��Ѵ�. ���� format�� �����Ͽ��� ��쿡�� format�� �´��� �˻��Ѵ�.

 * <pre>

 *     "number" �� ������ : �������� üũ

 *     "number=(5.2)" �� ������ : �����̸鼭 ������ 5�ڸ� ����, �Ҽ��� 2�ڸ� ���������� üũ

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

 * @desc   : validation�� �����Ѵ�.

 * @sig    : value

 * @param  : value   required ��ȿ�� �˻� ���.

 * @return : boolean. ��ȿ�� ����.

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

 * @desc   : 'minNumber' �׸� ���� validator. ���� ������ �ּҰ��� �Ѵ����� �˻��Ѵ�.

 * @sig    : minNumber

 * @param  : minNumber required ��ȿ�� ���� �ּҰ�.

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

 * @desc   : validation�� �����Ѵ�.

 * @sig    : value

 * @param  : value   required ��ȿ�� �˻� ���.

 * @return : boolean. ��ȿ�� ����.

 */

function covMinNumberValidator_validate(value) {

	// ���ذ��� ���ڰ� �ƴѰ�� ������ true;

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

 * @desc   : 'maxNumber' �׸� ���� validator. ���� ������ �ִ밪�� ���� �ʴ����� �˻��Ѵ�.

 * @sig    : maxNumber

 * @param  : maxNumber ��ȿ�� ���� �ִ밪.

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

 * @desc   : validation�� �����Ѵ�.

 * @sig    : value

 * @param  : value   required ��ȿ�� �˻� ���.

 * @return : boolean. ��ȿ�� ����.

 */

function covMaxNumberValidator_validate(value) {

	// ���ذ��� ���ڰ� �ƴѰ�� ������ true;

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

 * @desc   : 'inNumber' �׸� ���� validator. ���� ������ ���� ���� �������� �˻��Ѵ�.

 * @sig    : inNumber

 * @param  : inNumber required ������ ������ ��Ÿ���� ��Ʈ��. ��) "1~100"

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

 * @desc   : validation�� �����Ѵ�.

 * @sig    : value

 * @param  : value   required ��ȿ�� �˻� ���.

 * @return : boolean. ��ȿ�� ����.

 */

function covInNumberValidator_validate(value) {

	// ���ذ��� ���ڰ� �ƴѰ�� ������ true;

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

 * @desc   : 'minDate' �׸� ���� validator. ���� ������ ��¥�� �Ѵ����� �˻��Ѵ�.

 *           'YYYYMMDD' �������� ��¥�� ǥ���ؾ� �Ѵ�.

 *             ��) minDate=20020315

 * @sig    : minDate

 * @param  : minDate required ��ȿ�� ���� �ּҰ�.

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

 * @desc   : validation�� �����Ѵ�.

 * @sig    : value

 * @param  : value   required ��ȿ�� �˻� ���.

 * @return : boolean. ��ȿ�� ����.

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

 * @desc   : 'maxDate' �׸� ���� validator. ���� ������ �ִ밪�� ���� �ʴ����� �˻��Ѵ�.

 * @sig    : maxDate

 * @param  : maxDate required ��ȿ�� �ִ볯¥��.

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

 * @desc   : validation�� �����Ѵ�.

 * @sig    : value

 * @param  : value   required ��ȿ�� �˻� ���.

 * @return : boolean. ��ȿ�� ����.

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

 * @desc   : 'format' �׸� ���� validator. ���� ����ũ�� ǥ���� ���İ� ��ġ�ϴ��� �˻��Ѵ�.

 *             - format characters

 *               #    : ���ڿ� ����

 *               h, H : �ѱ� (H�� ��������)

 *               A, Z : ���� (Z�� ��������)

 *               0, 9 : ���� (9�� ��������)

 * @sig    : format

 * @param  : format required ���� ��Ʈ��.

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

 * @desc   : validation�� �����Ѵ�.

 * @sig    : value

 * @param  : value required ��ȿ�� �˻� ���.

 * @return : boolean. ��ȿ�� ����.

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

 * @desc   : 'ssn' �׸� ���� validator. �Էµ� �ֹε�Ϲ�ȣ�� ��ȿ���� �˻��Ѵ�.

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

 * @desc   : validation�� �����Ѵ�.

 * @sig    : ssn

 * @param  : ssn required ��ȿ�� �˻� ���.

 * @return : boolean. ��ȿ�� ����.

 */

function covSsnValidator_validate(ssn) {

	if ( ssn == null || ssn.trim().length != 13 || isNaN(ssn) )  {

		this.message = new coMessage().getMsg(MSG_COM_ERR_016, ["@"]);

		return false;

	}



	var jNum1 = ssn.substr(0, 6);

	var jNum2 = ssn.substr(6);



	/*

	  �߸��� ��������� �˻��մϴ�.
	  2000�⵵���� ������ ��ȣ�� �ٲ������ �������� 2���� �۴ٸ�
	  1900�⵵ ���̵ǰ� 2���� ũ�ٸ� 2000�⵵ �̻���� �˴ϴ�.
	  �� 1800�⵵ ���� ��꿡�� �����մϴ�.

	*/
	bYear = (jNum2.charAt(0) <= "2") ? "19" : "20";

	// �ֹι�ȣ�� �տ��� 2�ڸ��� �̾ 4�ڸ��� ������ �����մϴ�.
	bYear += jNum1.substr(0, 2);


	// ���� ���մϴ�. 1�� ������ �ڹٽ�ũ��Ʈ������ 1���� 0���� ǥ���ϱ� �����Դϴ�.
	bMonth = jNum1.substr(2, 2) - 1;


	bDate = jNum1.substr(4, 2);


	bSum = new Date(bYear, bMonth, bDate);


	// ��������� Ÿ�缺�� �˻��Ͽ� ������ ������ �����޼����� ��Ÿ��
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


		// �� ���� ���� ���� �̾Ƴ��ϴ�. ������ ���� 10���� ũ�ų� ���ٸ� ���Ŀ� ���� 2�� �ٽ� �����ϰ� �˴ϴ�.
		if(k >= 10) k = k % 10 + 2;


		// �� �ڸ����� ������ ���Ѱ��� ���� total�� �����ջ��ŵ�ϴ�.
		total = total + (temp[i] * k);
	}

	// ������ ������ ���� last_num�� �����մϴ�.
	last_num = (11- (total % 11)) % 10;


	// laster_num�� �ֹι�ȣ�Ǹ��������� ������ ���� Ʋ���� ������ ��ȯ�մϴ�.
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

 * @desc   : 'csn' �׸� ���� validator. �Էµ� ����ڵ�Ϲ�ȣ�� ��ȿ���� �˻��Ѵ�.

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

 * @desc   : validation�� �����Ѵ�.

 * @sig    : csn

 * @param  : csn required ��ȿ�� �˻� ���.

 * @return : boolean. ��ȿ�� ����.

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

 * @desc   : ������ ���� �̿ܿ� �ٸ� ���ڰ� ������� ��� ��ȿ���� ���� ������ �Ǵ��Ѵ�.

 *           Ư�� ���ڵ鿡 ���� Ư�����ڰ� �Ʒ��� �����ִ�.<br>

 * <pre>

 *         ;    - \;

 *         �ѱ� - \h

 *         ���� - \a

 *         ���� - \n

 * </pre>

 * @sig    : fStr

 * @param  : fStr required filter�� ���� ǥ��

 * @author : GAUCE

 */

function covFilterInValidator(fStr) {

    // data;

    this.message = "";

    this.validity = false;

    this.fStrArr = fStr.advancedSplit(";", "i");



    for (var i = 0; i < this.fStrArr.length; i++) {

    	if (this.fStrArr[i] == "\\h") {

    		this.fStrArr[i] = "�ѱ�";

    	} else if (this.fStrArr[i] == "\\a") {

    		this.fStrArr[i] = "����";

    	} else if (this.fStrArr[i] == "\\n") {

    		this.fStrArr[i] = "����";

    	}

    }



    // method

    this.validate = covFilterInValidator_validate;

}



/**

 * @type   : method

 * @access : public

 * @object : covFilterInValidator

 * @desc   : validation�� �����Ѵ�.

 * @sig    : value

 * @param  : value required ��ȿ�� �˻� ���.

 * @return : boolean. ��ȿ�� ����.

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

			if (this.fStrArr[j] == "�ѱ�" &&

			    ((0xAC00 <= cCode && cCode <= 0xD7A3) || (0x3131 <= cCode && cCode <= 0x318E))

			   ) {

				isIn = true;

			} else if ( this.fStrArr[j] == "����" &&

			            ((0x61 <= cCode && cCode <= 0x7A) || (0x41 <= cCode && cCode <= 0x5A))

			          ) {

				isIn = true;

			} else if (this.fStrArr[j] == "����" && !isNaN(c)) {

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

 * @desc   : ������ ��Ʈ������ ������� ��� ��ȿ���� ���������� �Ǵ��Ѵ�.

 *           �и��ڴ� ";"�� ����Ѵ�. ";" Ȥ�� ";"���ڰ� �� ��Ʈ���� ���͸��Ϸ� �� ����

 *           "\\;"��� ǥ���ؾ� �Ѵ�.

 * @sig    : fStr

 * @param  : fStr required filter�� ���� ǥ��

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

 * @desc   : validation�� �����Ѵ�.

 * @sig    : value

 * @param  : value required ��ȿ�� �˻� ���.

 * @return : boolean. ��ȿ�� ����.

 */

function covFilterOutValidator_validate(value) {

	for (var i = 0; i < this.fStrArr.length; i++) {

		if (value.indexOf(this.fStrArr[i]) != -1) {

			this.message = new coMessage().getMsg(MSG_COM_ERR_033, ["@", "����Ҽ� ���� ���� : " + this.fStrArr.toString()]);

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

 * @desc   : �Է°��� email ���Ŀ� ���������� �˻��Ѵ�.

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

 * @desc   : validation�� �����Ѵ�.

 * @sig    : value

 * @param  : value required ��ȿ�� �˻� ���.

 * @return : boolean. ��ȿ�� ����.

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

 * @desc   : ���� Date���������� �˻��Ѵ�.

 *

 *            format���� :  YYYY,  -> 4�ڸ� �⵵

 *                          YY,    -> 2�ڸ� �⵵. 2000�� ����.

 *                          MM,    -> 2�ڸ� ������ ��.

 *                          DD,    -> 2�ڸ� ������ ��.

 *                          hh,    -> 2�ڸ� ������ �ð�. 12�� ����

 *                          HH,    -> 2�ڸ� ������ �ð�. 24�� ����

 *                          mm,    -> 2�ڸ� ������ ��.

 *                          ss     -> 2�ڸ� ������ ��.

 *

 *            ��)

 *                'YYYYMMDD' -> '20020328'

 *                'YYYY/MM/DD' -> '2002/03/28'

 *                'Today : YY-MM-DD' -> 'Today : 02-03-28'

 *

 *            ����)

 *                  format���ڰ� �ߺ��ؼ� �������� ó�� ���� ���ڿ� ���ؼ���

 *                  format���ڷ� �νĵȴ�. YYYY�� YY, hh�� HH �� �ߺ����� ����.

 *                  ��¥�� ��,���� ������ ���� ��Ȯ�� üũ�ϰ� ���� ��, ���� ���ٸ�

 *                  1 ~ 31 ���������� üũ�Ѵ�.

 *

 * @sig    : dateExp

 * @param  : dateExp required Date Format expression.

 *             ��) 2002�� 3�� 12�� -> "YYYY-MM-DD"(Date Format Expression) -> "2002-03-12"

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

 * @desc   : validation�� �����Ѵ�.

 * @sig    : value

 * @param  : value   required �˻����� �Ǵ� Date ��Ʈ�� ��.

 * @return : boolean - ��ȿ�� ����

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

 * @desc   : ������ valid�� ����� ���� validator.

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

 * @desc   : validation�� �����Ѵ�.

 * @return : boolean - ������ true.

 */

function covNullValidator_validate() {

	this.message = new coMessage().getMsg(MSG_COM_INF_007);

	return true;

}



// ---------------------------------- login�� ���õ� ��ũ��Ʈ�Դϴ�. ------------------------------ //

// �κ� ����带 ���Ͽ� �Ϻ� ���� ���� 2003.2.27



/**

 * @type   : function

 * @access : public

 * @desc   : ȯ�� ���� ���콺 �����ͼ��� ���� ȣ���Ѵ�.

 * @return : �ش� �ʵ� ��

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

 * @desc   : ���� �α��� ������� ����ھ��̵� ��ȯ�Ѵ�.

 * @return : ����ھ��̵�(userId)

 * @author : GAUCE

 */

function cfGetLoginUserId()

{

  return cfGetLoginGlobalSerttingObj("userId");

}



/**

 * @type   : function

 * @access : public

 * @desc   : ���� �α��� ������� ����ڸ��� ��ȯ�Ѵ�.

 * @return : ����ڸ�(userNm)

 * @author : GAUCE

 */

function cfGetLoginUserNm()

{

  return cfGetLoginGlobalSerttingObj("userNm");

}



/**

 * @type   : function

 * @access : public

 * @desc   : ���� �α��� ������� ���뱹��ȣ�� ��ȯ�Ѵ�.

 * @return : ���뱹��ȣ(regiPoCd)

 * @author : GAUCE

 */

function cfGetLoginRegiPoCd()

{



  return cfGetLoginGlobalSerttingObj("regiPoCd");

}



/**

 * @type   : function

 * @access : public

 * @desc   : ���� �α��� ������� ���뱹��ȣ���� ��ȯ�Ѵ�.

 * @return : ���뱹��ȣ��(regiPoCdNm)

 * @author : GAUCE

 */

function cfGetLoginRegiPoCdNm()

{

  return cfGetLoginGlobalSerttingObj("regiPoCdNm");

}



/**

 * @type   : function

 * @access : public

 * @desc   : ���� �α��� ������� ���ڵ���� ��ȯ�Ѵ�.

 * @return : ���ڵ��(deptCdNm)

 * @author : GAUCE

 */

function cfGetLoginDeptCdNm()

{

  return cfGetLoginGlobalSerttingObj("deptCdNm");

}



 /**

 * @type   : function

 * @access : public

 * @desc   : ���� �α��� ������� ���ڵ带 ��ȯ�Ѵ�.

 * @return : ���ڵ�(deptCd)

 * @author : GAUCE

 */

function cfGetLoginDeptCd()

{

  return cfGetLoginGlobalSerttingObj("deptCd");

}





 /**

 * @type   : function

 * @access : public

 * @desc   : ���� �α��� ������� ���ڵ���� ��ȯ�Ѵ�.

 * @return : ���ڵ��(sectCdNm)

 * @author : GAUCE

 */

function cfGetLoginSectCdNm()

{

  return cfGetLoginGlobalSerttingObj("sectCdNm");

}



 /**

 * @type   : function

 * @access : public

 * @desc   : ���� �α��� ������� ���ڵ带 ��ȯ�Ѵ�.

 * @return : ���ڵ�(sectCd)

 * @author : GAUCE

 */

function cfGetLoginSectCd()

{

  return cfGetLoginGlobalSerttingObj("sectCd");

}



 /**

 * @type   : function

 * @access : public

 * @desc   : ���� �α��� ������� ��å�ڵ带 ��ȯ�Ѵ�.

 * @return : ��å�ڵ�(posCd)

 * @author : GAUCE

 */

function cfGetLoginPosCd()

{

  return cfGetLoginGlobalSerttingObj("posCd");

}



 /**

 * @type   : function

 * @access : public

 * @desc   : ���� �α��� ������� ��å�ڵ���� ��ȯ�Ѵ�.

 * @return : ��å�ڵ��(posCdNm)

 * @author : GAUCE

 */

function cfGetLoginPosCdNm()

{

  return cfGetLoginGlobalSerttingObj("posCdNm");

}







 /**

 * @type   : function

 * @access : public

 * @desc   : ���� �α��� ������� ���������ھ��̵� ��ȯ�Ѵ�.

 * @return : ���������ھ��̵�(hrnkSancPrsnID)

 * @author : GAUCE

 */

function cfGetLoginHrnkSancPrsnID()

{

  return cfGetLoginGlobalSerttingObj("hrnkSancPrsnID");

}



 /**

 * @type   : function

 * @access : public

 * @desc   : ���� �α��� ������� ��ü�ڵ带 ��ȯ�Ѵ�.

 * @return : ��ü�ڵ�(compCd)

 * @author : GAUCE

 */

function cfGetLoginCompCd()

{

  return cfGetLoginGlobalSerttingObj("compCd");

}



 /**

 * @type   : function

 * @access : public

 * @desc   : ���� �α��� ������� ��/�ܺλ���ڱ����ڵ带 ��ȯ�Ѵ�.

 * @return : ��/�ܺλ���ڱ����ڵ�(insOutUserGbCd)

 * @author : GAUCE

 */

function cfGetLoginInsOutUserGbCd()

{

  return cfGetLoginGlobalSerttingObj("insOutUserGbCd");

}







 /**

 * @type   : function

 * @access : public

 * @desc   : ���� �α��� ������� ������ ���� IP �� ��ȯ�Ѵ�.

 * @return : ������ IP

 * @author : GAUCE

 */

function cfGetLoginUserMPOIP( )

{

 return cfGetLoginGlobalSerttingObj("mpoip");

}



 /**

 * @type   : function

 * @access : public

 * @desc   : ���� �α��� ������� ���� IP �� ��ȯ�Ѵ�.

 * @return : ����IP

 * @author : GAUCE

 */

function cfGetLoginUserRemoteAddr( )

{

 return cfGetLoginGlobalSerttingObj("remoteAddr");

}



 /**

 * @type   : function

 * @access : public

 * @desc   : ���� �α��� ������� UPDATE����������� ��ȯ�Ѵ�.

 * @return : ����IP

 * @author : GAUCE

 */

function cfGetLoginUserUpdateID( )

{

 return cfGetLoginGlobalSerttingObj("updateID");

}





/**

 * @type   : function

 * @access : public

 * @desc   : ���� �α��� ������� ���������� ǥ���Ѵ�.

 * @author : GAUCE

 */

function cfGetLoginShowGlobalSertting() {



   alert(

         '===== ����� ���� ���� =====\n'+

         '����ھ��̵�['+cfGetLoginUserId()+']\n'+

         '����ڸ�['+cfGetLoginUserNm()+']\n'+

         '���뱹��ȣ['+cfGetLoginRegiPoCd()+']\n'+

         '���뱹��ȣ��['+cfGetLoginRegiPoCdNm()+']\n'+

         '���ڵ��['+cfGetLoginDeptCdNm()+']\n'+

         '���ڵ�['+cfGetLoginDeptCd()+']\n'+

         '���ڵ�['+cfGetLoginSectCd()+']\n'+

         '���ڵ��['+cfGetLoginSectCdNm()+']\n'+

         '��å�ڵ�['+cfGetLoginPosCd()+']\n'+

         '��å�ڵ��['+cfGetLoginPosCdNm()+']\n'+

         '���������ھ��̵�['+cfGetLoginHrnkSancPrsnID()+']\n'+

         '��ü�ڵ�['+cfGetLoginCompCd()+']\n'+

         '��/�ܺλ���ڱ����ڵ�['+cfGetLoginInsOutUserGbCd()+']\n'+

         '������IP['+cfGetLoginUserMPOIP()+']\n'+

         '����IP['+cfGetLoginUserRemoteAddr()+']\n'+

         'UPDATE���������['+cfGetLoginUserUpdateID()+']'

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

  // open window �Ǵ� dialog ��� �ǹ�
   try {
       var checkName = self ;

       while ( !checkTargetOpenerExist(checkName) ) {

    	   checkName = checkName.top.opener ;

       }
   } catch ( exception ) {
       // opener �� ã�� �������� ������ ���� dialog ��� �ǹ�
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

 * @desc   : ���� �α��� ����ڿ���  �ش� �����ڵ尡 �ִ��� üũ �Ѵ�.

 * @return : boolean - �����ڵ尡 ���� ��� true

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

 * @desc   : Ŀ������� �ٲپ� �ִ� �Լ�

 * @param  : theType  Ŀ�����

 *          0 : ����Ʈ(ȭ��ǥ)

 *          1 : �𷡽ð�

 *          2 : ����

 *          3 : �ո��

 * @author : GAUCE

 */

var arrayInput  = "";	// INPUT TAG �迭...

var arrayCombo = "";			// �ڵ��޺� TAG �迭...

var arrayObject = "";			// ���콺 ������Ʈ �迭...

var arrayA = "";					// A TAG�迭...

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



	// INPUT TAG�� ����..

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



	// A TAG�� ����..

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



	// ���콺 ������Ʈ �迭..

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

				case "CLSID:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49": // �׸���.
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

				case "CLSID:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49": // �׸���.
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
						if (tagList[i].text != "�����Ͱ� �����ϴ�.")
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

 * @desc   : �����޴� ���� ����

 * @author : GAUCE

 */


function checkDynamicMenu( ) {
  return true  ;

  //return false  ;



  if ( checkServerDomain() ) return true ;

  else return false ;
}





/*

 �۾�ó���� �˾� ȭ���� ���� / �ݴ� ���� ����

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

   alert('�ݱ� ����(X)�� ���������ʽÿ�') ;

   fncProgressWinOpen();

}



 /**

 * @type   : function

 * @access : public

 * @desc   : �۾��� ������ ǥ��

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

 * @desc   : �۾��� ������ ����

 * @author : GAUCE

 */

function fncProgressWinClose() {



  document.documentElement.disabled = false ;

  cfChangeCursor( 0 ) ;

  try {

    popUpProgressWindowReference = window.open( "","wait_please","top=2000,left=2000,width=1,height=1,menubar=no,status=no,titlebar=no" );
    popUpProgressWindowReference.closeWin();

  }catch( Exception ){

    // �����찡 �̹� ���� ��� �׳� �����Ѵ�.

  }
}





/**

 * @type   : function

 * @access : public

 * @desc   : ����� �����Ͱ� �ִµ� �ٸ� �޴��� Ŭ���ϴ� ��� html body�� onbeforeunload event����

 *           �ٸ��޴��� �̵��Ұ�����(cfChangeDataChk �Լ�ȣ��) �ƴ����� ���� Ȯ�� �޼����� �ش�

 * @sig    : oDataSetId

 * @param  : oDataSetId ���������� Ȯ���Ϸ����ϴ� �����ͼ� �̸�

 * @return :

 * <pre>

 *     oDataSet : ���������� Ȯ���Ϸ����ϴ� �����ͼ� �̸�

 *     ��뿹) <body onbeforeunload="cfChangeDataChk(oDataSet)">

 * </pre>

 * @author : ���α�

 */



function cfChangeDataChk(oDataSetId) {

	if (oDataSetId.isUpdated){

		event.returnValue = "��������� �ݿ����� �ʾҽ��ϴ�.";

	}

}



/**
 * @type   : function
 * @access : public
 * @desc   : �׸��� �󿡼� enter�� key�� ġ�� ��� tab ó�� ������ �Ʒ��� �̵��Ѵ�.
 *           �̵��� ������ edit������ Į�� ������ �̵��Ѵ�.
 *           �׸����� onkeypress event���� ȣ�� �ϸ� �ȴ�. (keycode 13�̸� enter Ű�̴�.)
 * @sig    : oGrid
 * @param  : oGrid enter key ó���� �׸��� object id
 * @return :
 * <pre>
 *     ��뿹)
 *     oGrid : object id
 *     <script language=JavaScript for=oGrid event=OnKeyPress(kcode)>
 * 		if ( kcode == '13' ) // key code 13�� enter key
 *			fncGridEnterKey(oGrid);
 *     </script>
 * </pre>
 * @author : ���α�
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

	// Grid Format String �� �Ľ��Ͽ� �÷����� Style �� ���õ� �Ӽ��� �����Ѵ�.
	while ((tagMatch = gFormat.match(tagRE)) != null) {
		var gridColid ="";
		var editstyle ="";
		var showFalse ="";

		// ����ڰ� ������ �÷� �Ӽ��� ���� ó��
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

		curColIndex   = curDataSet.ColumnIndex(gridColid);  		//column id�� �ش��ϴ� index��
		curColProp	  = curDataSet.ColumnProp(curColIndex);     // 0:"NORMAL", 1:"CONSTANT", 2:"KEYVALUE"(����ȵ�)

		tagName = tagMatch[1].trim().toUpperCase();

		if ( tagName =='C' || tagName =='FC' ){
			if ( editstyle != "NONE" && curColProp != "2" && showFalse != "FALSE" ){
				newFormat = newFormat + gridColid+',';
			}
		}
	}

	TempGDS.setdataheader(newFormat); //�׸��� format�� �ش��ϴ� Į�� ������ temp�� ������ ���� �����Ѵ�.
								 	  //�����ͼ°� �׸����� Į�� ������ ����ġ...
	var currColumn    = oGrid.GetColumn();
	var currColummIdx = TempGDS.ColumnIndex(currColumn);  //���缱�õ� Į���� index
	var CurrRowNoChg  = 'Y';

	for (var i = 1; i <= TempGDS.CountColumn; i++) {
		colId      = TempGDS.ColumnID(i);	      //column id
		colIndex   = TempGDS.ColumnIndex(colId);  //column id�� �ش��ϴ� index��
		colProp	   = TempGDS.ColumnProp(i);       // 0:"NORMAL", 1:"CONSTANT", 2:"KEYVALUE"(����ȵ�)
		editStatus = oGrid.ColumnProp(colId,"edit");

		if ( currColummIdx < colIndex ) {
			oGrid.focus();
			oGrid.SetColumn(colId);
			return;
		}
	}

	//enter event ������ row�ΰ��� ���� row�� �̵��Ѵ�.
	if ( CurrRowNoChg == 'Y' ){
		curDataSet.RowPosition =  curDataSet.RowPosition + 1;

		for (var i = 1; i <= TempGDS.CountColumn; i++) {
			colId      = TempGDS.ColumnID(i);	      //column id
			colIndex   = TempGDS.ColumnIndex(colId);  //column id�� �ش��ϴ� index��
			colProp	   = TempGDS.ColumnProp(i);       // 0:"NORMAL", 1:"CONSTANT", 2:"KEYVALUE"(����ȵ�)
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
 * @desc   : �ٿ�ε�ÿ� �Ѱ��� ������ ����� ������ ���θ� ���� �Ѵ�.
 * @author : GAUCE
 */

function fncUseMPOServer() {
 // �Ѱ��� ������ ����� ��� return true �� ����
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

//==========  ������ �����
function ln_Excel(obj,title){
//	var tbgd_Excel=

        obj.SetExcelTitle(0, "");
	TitleText = "value:" + title + ";font-face:����ü;font-size:30pt;font-color:black;font-bold;font-underline;bgcolor:#CCFFCC;align: center;line-color:#C0C0C0;line-width:0.5pt;skiprow:1;";
	obj.SetExcelTitle(1, TitleText);
	var today = new Date();
	var day = today.getDay();
	var week;
	if (day==0) {week="�Ͽ���";}
	else if (day==1) {week="������";}
	else if (day==2) {week="ȭ����";}
	else if (day==3) {week="������";}
	else if (day==4) {week="�����";}
	else if (day==5) {week="�ݿ���";}
	else if (day==6) {week="�����";}
	var hour = today.getHours();
	if (hour>12) {hour="���� "+(hour-12);}
  else {hour="���� "+hour;}
  var minute = today.getMinutes();
  var second = today.getSeconds();

	var ymd = today.getYear() +"�� "+ (today.getMonth() + 1) +"�� "+ today.getDate() + "��"
  var hms = hour + "�� " + minute + "�� " +  second + "��";
  TitleText = "value : ������� : " + ymd + " ("+ week + ")";
  TitleText+= "\n" + hms;
	TitleText+= "; font-face: '����ü';font-size: 12pt;font-color:#336600;font-italic;bgcolor:#ffffff;align:right;line-color: #C0C0C0;line-width:0.5pt;skiprow: 1;";
	obj.SetExcelTitle(1, TitleText);

	var g_Excelfile_type ="0";

	g_Excelfile_type = ln_Excel_file();

    if (g_Excelfile_type == undefined ){//������ �ޱ�
        obj.GridtoExcel(title,"",1);
    }else if (g_Excelfile_type =="1"){//���Ϸ� �ޱ�
			//obj.ExportFile(title,'true');
		obj.GridtoExcel(title,title,29);
	}else if (g_Excelfile_type =="2"){//������ �ޱ�
			obj.GridtoExcel(title,"",1);
	}else if (g_Excelfile_type =="3"){//�ؽ�Ʈ ���� ����� �����
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
 * IE ��ġ�� ���� �Լ� �߰�
 ===========================================================================*/
function __ws__(id){
	document.write(id.innerHTML);
	id.id = "";
}

/*===========================================================================*/
// ���ڿ��� ġȯ�� �� ������� ��ȯ�Ѵ�.
/*===========================================================================*/
function replaceStr(pStr, pFind, pReplace)	{

	// ���� ����(�ش� ���ڸ� ��� ã�Ƽ� ��ȯ����).
	var newPattern = new RegExp(pFind, "gi");

	return pStr.replace(newPattern, pReplace);
}

/*===========================================================================*/
// �׸����� �ش簪�� �ش��ϴ� ���� Row�� ã�Ƽ�, Focus�� �̵�
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
// ���� ����ִ����� üũ�Ͽ� ��������� �ش� �޼����� �����ش�.
// ���� ������� ��� true�� ��ȯ�Ѵ�.
/*===========================================================================*/
function isEmpty(pObject, pMsg, pLen, pLenFlag)	
{

	//----------
	// FM : �ʼ��Է��̰� data���̰� fix�� ���
	//  M : �ʼ��Է��̰� data���̰� �ʰ��� ���
	// NM : data���̰� �ʰ��� ��츸
	//----------

	//alert(pObject.outerHTML);
	if (pLenFlag == null) pLenFlag = "";

	if (pObject.tagName.toUpperCase() == "INPUT" || pObject.tagName.toUpperCase() == "TEXTAREA")	
	{
		if ( pLenFlag =="" && pObject.value=="")	
		{
			if (pMsg)	alert("[" + pMsg + "]��(��) �Է��ϼ��� !!!");

			if(pObject.disabled==false) pObject.focus();
			return true;
		}
		else if (pLenFlag=="FM" && pLen && getByteLength(pObject) !=pLen )	
		{
			alert("[" + pMsg +"]�� ���̰� ���� �ʽ��ϴ�.\n\n�ش� �׸��� ���̴� " + pLen +"�� �Դϴ�.\n(�ѱ��� 2����Ʈ ����/���ڴ� 1����Ʈ�� ���˴ϴ�.)");
			pObject.focus();
			pObject.select();
			return true;
		}
		else if (pLenFlag=="M" && pLen && getByteLength(pObject) == 0 )	
		{
			alert("[" + pMsg +"]��(��) �Է��ϼ��� !!!");
			if(pObject.disabled==false) 
			{
				pObject.focus();
				pObject.select();
			}
			return true;
		}
		else if (pLenFlag=="M" && pLen && getByteLength(pObject) > pLen )	
		{
			alert("[" + pMsg +"]�� ���̰� �ʹ� ��ϴ�.\n\n�ش� �׸��� ���̴� " + pLen +"����Ʈ�� �ʰ��� �� �����ϴ�.\n(�ѱ��� 2����Ʈ ����/���ڴ� 1����Ʈ�� ���˴ϴ�.)");
			pObject.focus();
			pObject.select();
			return true;
		}
		else if (pLenFlag=="NM" && pLen && getByteLength(pObject) > pLen )	
		{
			alert("[" + pMsg +"]�� ���̰� �ʹ� ��ϴ�.\n\n�ش� �׸��� ���̴� " + pLen +"����Ʈ�� �ʰ��� �� �����ϴ�.\n(�ѱ��� 2����Ʈ ����/���ڴ� 1����Ʈ�� ���˴ϴ�.)");
			pObject.focus();
			pObject.select();
			return true;
		}

	}
	else if (pObject.tagName.toUpperCase() == "SELECT")	
	{
		if (pObject.selectedIndex == 0 && pObject.value=="")	
		{
			if (pMsg)	alert("[" + pMsg + "]��(��) �����ϼ��� !!!");

			pObject.focus();
			return true;
		}
	}
	else	
	{
		alert("�Ű������� �Ѿ�� ��ü�� INPUT Ÿ���� �ƴմϴ�.");
		return true;
	}

	return false;
}

/*===========================================================================*/
// byte�� ����
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
  * �� �� �� : ln_TRSetting()
  * �Ű����� : ����
  * ��    �� : Transation Parameter Setting
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
  * �� �� �� : tr_post()
  * �Ű����� : ����
  * ��    �� : Transation Post
  */
function tr_post(a_TR)
{
	a_TR.post();
}	

/*
 * Progress Bar Start
 */
function fnOnProgressStart(){
    window.status="��ø� ��ٷ� �ֽñ�ٶ��ϴ�.";
//    getObjectFirst("LowerFrame").style.visibility="visible";
}

/*
 * Progress Bar End
 */
function fnOnProgressEnd(){
    window.status="��ȸ�� �Ϸ�Ǿ����ϴ�..";
    getObjectFirst("LowerFrame").style.visibility="hidden";
}

/**
 * �ֹε�� ��ȣ�� üũ�Ѵ�.
 * @param obj1 �ֹι�ȣ ���ڸ�(1~6)
 * @param obj2 �ֹι�ȣ ���ڸ�(7~13)
 * @author ���ؼ�
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
        alert ("�ֹε�Ϲ�ȣ�� ��Ȯ�� �Է��� �ּ���.");
        return false;
    }
/*    if ((sex != 1 && sex !=2 && sex !=3 && sex !=4))   {
        alert ("�ֹε�Ϲ�ȣ�� ��Ȯ�� �Է��� �ּ���.");
        return false;
    }*/

    for (var i = 0; i <=11 ; i++)
       tmp = tmp + ((i%8+2) * parseInt(obj1.substring(i,i+1)))

    tmp = 11 - (tmp %11)
    tmp = tmp % 10
//alert(tmp + " : " + sex);
    if (tmp != obj1.substring(12))
    {
        alert ("�߸��� �ֹε�Ϲ�ȣ�Դϴ�.");
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
 * �Ϲ���ȭ �� �޴���ȭ��ȣ ���� ����
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
