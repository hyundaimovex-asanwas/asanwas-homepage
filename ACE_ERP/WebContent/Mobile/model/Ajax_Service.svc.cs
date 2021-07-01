using System;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Activation;
using System.ServiceModel.Web;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Security.Cryptography;
using System.Drawing;
using System.Drawing.Imaging;

using ServiceStack.Text;
using GST.Library;
using GST.Components;
using Mobile.Base.Web;
using Mobile.Base.Data;
using Mobile.Base.Util;
using Mobile.Base.Crypto;
using Mobile.Base.WcfService1;

namespace Mobile
{
    [ServiceContract(Namespace = "")]
    [AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]

    public class Ajax_Service
    {
        #region Common

        private bool CheckLogin()
        {
            if (UserInfo.IsLogin())
            {
                if (UserInfo.HASH != Hash.SHA256(UserInfo.ID_USER + UserInfo.CD_CORP + UserInfo.CD_DEPT))
                {
                    return false;
                }
            }
            else
            {
                return false;
            }
            return true;
        }

        private Dictionary<string, string> DecodeContent(string inputContent)
        {
            Dictionary<string, string> jsonData = null;
            try
            {
                byte[] byteBase64 = StringHelper.FromBase64(inputContent);
                string decodeBase64 = StringHelper.UTF8BytesToString(byteBase64);

                jsonData = JsonSerializer.DeserializeFromString<Dictionary<string, string>>(decodeBase64);
            }
            catch
            {
            }
            return jsonData;
        }

        private List<string> DecodeContentList(string inputContent)
        {
            List<string> jsonData = null;
            try
            {
                byte[] byteBase64 = StringHelper.FromBase64(inputContent);
                string decodeBase64 = StringHelper.UTF8BytesToString(byteBase64);

                jsonData = JsonSerializer.DeserializeFromString<List<string>>(decodeBase64);
            }
            catch
            {
            }
            return jsonData;
        }
        #endregion

        #region User

        #region PublicKey
        /// <summary>
        /// 공개키 가져오기
        /// </summary>
        /// <returns></returns>
        [OperationContract]
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest, ResponseFormat = WebMessageFormat.Json)]
        public JsonOutput PublicKey()
        {
            try
            {
                // 공개키 로드
                RSACrypto rsa = new RSACrypto(System.Web.Hosting.HostingEnvironment.MapPath("~/cert"), false);
                RSAParameters param = rsa.ExportParameters(false);

                AjaxDictionary<string, object> dic = new AjaxDictionary<string, object>();
                dic.Add("E", StringHelper.BytesToHexString(param.Exponent));
                dic.Add("M", StringHelper.BytesToHexString(param.Modulus));

                JsonOutput jo = new JsonOutput();
                jo.data = dic;
                jo.success = true;
                return jo;
            }
            catch (Exception ex)
            {
                JsonOutput jo = new JsonOutput();
                jo.msg = ex.Message;
                jo.success = true;
                return jo;
            }
        }
        #endregion

        #region Login
        /// <summary>
        /// 로그인
        /// </summary>
        /// <param name="inputContent"></param>
        /// <returns></returns>
        [OperationContract]
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest, ResponseFormat = WebMessageFormat.Json)]
        public JsonData Login(string inputContent)
        {
            try
            {
                Dictionary<string, string> jsonData = DecodeContent(inputContent);

                // 비밀키 로드
                RSACrypto rsa = new RSACrypto(System.Web.Hosting.HostingEnvironment.MapPath("~/cert"), true);
                // 공개키로 암호화된 로그인정보
                string encodeText = jsonData["AUTH"]; 
                // 비밀키로 복호화
                string decodeText = StringHelper.ASCIIBytesToString(rsa.Decrypt(StringHelper.HexStringToBytes(encodeText))); 

                string[] spl_text = decodeText.Split('|');

                string id = StringHelper.ASCIIBytesToString(StringHelper.FromBase64(spl_text[0]));
                string pwd = StringHelper.ASCIIBytesToString(StringHelper.FromBase64(spl_text[1]));

                try
                {

                    string sso_id = "";
                    string sso_pass = "";

                    bool bSSOLogin = false; // SSO 사용할경우 true

                    if (id.ToLower() == "erpadmin")
                    {
                        bSSOLogin = false;
                    }

                    if (bSSOLogin)
                    {
                        string msg = "";
                        if (SSOLoginProcess("http://erp.elandconst.co.kr", id, pwd, "HOME", ref msg) == false)
                        {
                            JsonData jd = new JsonData();
                            jd.success = false;
                            jd.msg = msg;
                            return jd;
                        }
                    }
                    else
                    {
                        sso_id = id;
                        sso_pass = pwd;
                    }

                    //strSSOLogin = "000000:12345678:";
                    ///통합인증인경우 패스워드 관리를 안하므로 패스워드 없음.(이랜드)
                    if (strSSOLogin != "")
                    {
                        string[] strarry = strSSOLogin.Split(':');
                        sso_id = strarry[1].Trim();
                        sso_pass = "";
                    }

                    if (sso_id != "")
                    {
                        if (UserInfo.Login(sso_id, sso_pass))
                        {
                            JsonData jd = new JsonData();
                            jd.success = true;
                            return jd;
                        }
                        else
                        {
                            JsonData jd = new JsonData();
                            jd.success = false;
                            jd.msg = "사용자 아이디와 패스워드가 유효하지 않습니다.";
                            return jd;
                        }
                    }
                    else
                    {
                        JsonData jd = new JsonData();
                        jd.success = false;
                        jd.msg = "아이디와 암호를 입력하세요!";
                        return jd;
                    }

                }
                catch (Exception ex)
                {
                    JsonData jd = new JsonData();
                    jd.success = false;
                    jd.msg = "네트워크 장애입니다. ERP 관리자에게 문의하세요.";
                    return jd;
                }

                //if (UserInfo.Login(id, pwd))
                //{
                //    JsonData jd = new JsonData();
                //    jd.success = true;

                //    return jd;
                //}
                //else
                //{
                //    JsonData jd = new JsonData();
                //    jd.success = false;
                //    jd.msg = "아이디 또는 비밀번호를 확인하세요.";

                //    return jd;
                //}
            }
            catch (Exception ex)
            {
                JsonData jd = new JsonData();
                jd.success = false;
                jd.msg = ex.Message;

                return jd;
            }
        }

        string strSSOLogin = "";
        /// <summary>
        /// 통합인증을 위한 프락시
        /// </summary>
        eNovatorLogin.SSOService.Service1Client proxy;
        private void SSOCreateProxy(string ip)
        {

            //if (proxy != null)
            //{
            //    if (proxy.State != CommunicationState.Closed && proxy.State != CommunicationState.Faulted)
            //        return;
            //}

            //proxy = new ApiTest.SSOService.Service1Client();
            //// 보안셋팅
            //proxy.ClientCredentials.Windows.ClientCredential.UserName = "erpuser";
            //proxy.ClientCredentials.Windows.ClientCredential.Password = "erpuser";
            //// BaseClass를 상속받은 객체생성
            //proxy.InnerChannel.Faulted += new EventHandler(InnerChannel_Faulted);


            if (proxy != null)
            {
                if (proxy.State != CommunicationState.Closed && proxy.State != CommunicationState.Faulted)
                    return;
            }
            //else if (proxy.State != CommunicationState.Closed)
            //{
            //    return;
            //}
            // wcf 프락시 생성코드 (ABC,Address-Binding-Contract)
            System.ServiceModel.EndpointAddress addr = new System.ServiceModel.EndpointAddress(ip + "/SSOService/Service1/");
            System.ServiceModel.WSHttpBinding http = new System.ServiceModel.WSHttpBinding();

            proxy = new eNovatorLogin.SSOService.Service1Client(http, addr);
            //if (!AuthClient.EndPointAddress.ToUpper().Contains("LOCALHOST"))
            //{
            proxy.ClientCredentials.Windows.ClientCredential.UserName = "erpuser";
            proxy.ClientCredentials.Windows.ClientCredential.Password = "erpuser";
            //}

        }
        private void SSOCloseProxy()
        {
            if (proxy != null)
            {
                try
                {
                    if (proxy.State == CommunicationState.Opened)
                        proxy.Close();
                    else if (proxy.State == CommunicationState.Faulted)
                        proxy.Abort();
                }
                catch (CommunicationException)
                {
                    proxy.Abort();
                }
                catch (TimeoutException)
                {
                    proxy.Abort();
                }
            }

        }
        bool SSOLoginProcess(string ip, string id, string pass, string domain, ref string msg)
        {
            try
            {
                SSOCreateProxy(ip);
                string value = proxy.SSOLogin(id, pass, domain);
                SSOCloseProxy();

                if (value.StartsWith("00000"))
                {
                    strSSOLogin = value;
                    return true;
                }
                else if (value.StartsWith("31000"))
                {
                    msg = "패스워드가 올바르지 않습니다.!";
                    return false;
                }
                else if (value.StartsWith("32000"))
                {
                    msg = "패스워드가 올바르지 않습니다.!";
                    return false;
                }
                else if (value.StartsWith("40000"))
                {
                    msg = "사용자를 찾을 수 없습니다.!";
                    return false;
                }
                else
                    return true;
            }
            catch (Exception ex)
            {
                strSSOLogin = "";
                SSOCloseProxy();
                msg = ex.Message;
                //msg = "통합인증 방식을 지원하지 않습니다. 이 창을 감추기 위해서는 [설정]-[보안] 탭에서 기본인증을 선택하세요.!";
                return false;
            }


        }

        #endregion

        #region Logout
        /// <summary>
        /// 로그아웃
        /// </summary>
        /// <returns></returns>
        [OperationContract]
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest, ResponseFormat = WebMessageFormat.Json)]
        public JsonData Logout()
        {
            try
            {
                UserInfo.Logout();
                throw new Exception("LOGOUT");
            }
            catch (Exception ex)
            {
                JsonData jd = new JsonData();
                jd.success = false;
                jd.msg = ex.Message;

                return jd;
            }
        }
        #endregion

        #region CheckUser
        /// <summary>
        /// 로그인 여부 체크
        /// </summary>
        /// <returns></returns>
        [OperationContract]
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest, ResponseFormat = WebMessageFormat.Json)]
        public JsonData CheckUser()
        {
            try
            {
                if (!CheckLogin())
                {
                    UserInfo.Logout();
                    throw new Exception("LOGOUT");
                }
                else
                {
                    JsonData jd = new JsonData();
                    jd.success = true;

                    return jd;
                }
            }
            catch (Exception ex)
            {
                JsonData jd = new JsonData();
                jd.success = false;
                jd.msg = ex.Message;

                return jd;
            }
        }
        #endregion

        #endregion

        #region Command

        #region Select
        [OperationContract]
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest, ResponseFormat = WebMessageFormat.Json)]
        public JsonData Select(string inputContent)
        {
            Mobile.Base.Service.Proxy service = new Mobile.Base.Service.Proxy();

            try
            {
                Dictionary<string, string> inputData = DecodeContent(inputContent);

                GST.Library.clsParamBuilder SelectParam = new clsParamBuilder(clsParamBuilder.BuilderParamType.SelectParameters);

                string selectSp = string.Empty;
                string tableName = string.Empty;
                string paramJson = string.Empty;

                selectSp = inputData["SP"]; // 호출SP
                paramJson = inputData["PARAMS"];  // Parameters

                List<Dictionary<string, string>> paramData = JsonSerializer.DeserializeFromString<List<Dictionary<string, string>>>(paramJson);

                // Parameter 생성
                for (int i = 0; i < paramData.Count; i++)
                {
                    string paramName = "@" + paramData[i]["NAME"];
                    string paramTypeStr = paramData[i]["TYPE"];
                    string paramDirectStr = paramData[i]["DIRECTION"];
                    string paramValue = paramData[i]["VALUE"];

                    SqlDbType paramType = SqlDbType.VarChar;
                    ParameterDirection paramDirect = ParameterDirection.Input;

                    if (Enum.IsDefined(typeof(SqlDbType), paramTypeStr))
                    {
                        paramType = (SqlDbType)Enum.Parse(typeof(SqlDbType), paramTypeStr);
                    }
                    else
                    {
                        throw new Exception("파라미터 Type 오류 : " + paramName);
                    }
                    if (Enum.IsDefined(typeof(ParameterDirection), paramDirectStr))
                    {
                        paramDirect = (ParameterDirection)Enum.Parse(typeof(ParameterDirection), paramDirectStr);
                    }
                    else
                    {
                        throw new Exception("파라미터 Direction 오류 : " + paramName);
                    }

                    // 파라미터 추가
                    SelectParam.Add(paramName, paramDirect, 0, 0, 0, paramType, paramValue);
                }

                // 서비스 호출
                service.CreateProxy();

                DataSet ds = new DataSet();
                service.Client.SelectData(ref ds, "DATA", selectSp, SelectParam.Render());

                JsonData jd = new JsonData();
                jd.data = Json.GetDataTableToList(ds.Tables["DATA"]);
                jd.success = true;

                return jd;
            }
            catch (Exception exc)
            {
                string msg = exc.Message;
                if (exc.InnerException == null)
                {
                    try
                    {
                        ExceptionDetail innerException = ((FaultException<ExceptionDetail>)exc).Detail;

                        while (innerException != null)
                        {
                            if (innerException.InnerException.Type.ToUpper() == "SYSTEM.DATA.SQLCLIENT.SQLEXCEPTION")
                            {
                                msg = innerException.InnerException.Message;
                                break;
                            }
                            else
                            {
                                innerException = innerException.InnerException;
                            }
                        }
                    }
                    catch
                    {

                    }
                }

                JsonData jd = new JsonData();
                jd.success = false;
                jd.msg = msg;

                return jd;
            }
            finally
            {
                service.CloseProxy();
            }

        }
        #endregion

        #region MultiSelect
        [OperationContract]
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest, ResponseFormat = WebMessageFormat.Json)]
        public JsonDatas MultiSelect(string inputContent)
        {
            Mobile.Base.Service.Proxy service = new Mobile.Base.Service.Proxy();

            try
            {
                List<string> arrData = DecodeContentList(inputContent);

                string[] tableNames = new string[arrData.Count];
                string[] selectSps = new string[arrData.Count];
                string[] paramStr = new string[arrData.Count];

                for (int c = 0; c < arrData.Count; c++)
                {
                    Dictionary<string, string> inputData = JsonSerializer.DeserializeFromString<Dictionary<string, string>>(arrData[c]);

                    GST.Library.clsParamBuilder SelectParam = new clsParamBuilder(clsParamBuilder.BuilderParamType.SelectParameters);

                    string selectSp = string.Empty;
                    string tableName = string.Empty;
                    string paramJson = string.Empty;

                    selectSp = inputData["SP"]; // 호출SP
                    tableName = inputData["TABLENAME"]; // 테이블명
                    paramJson = inputData["PARAMS"];  // Parameters
                    List<Dictionary<string, string>> paramData = JsonSerializer.DeserializeFromString<List<Dictionary<string, string>>>(paramJson);

                    // Parameter 생성
                    for (int i = 0; i < paramData.Count; i++)
                    {
                        string paramName = "@" + paramData[i]["NAME"];
                        string paramTypeStr = paramData[i]["TYPE"];
                        string paramDirectStr = paramData[i]["DIRECTION"];
                        string paramValue = paramData[i]["VALUE"];

                        SqlDbType paramType = SqlDbType.VarChar;
                        ParameterDirection paramDirect = ParameterDirection.Input;

                        if (Enum.IsDefined(typeof(SqlDbType), paramTypeStr))
                        {
                            paramType = (SqlDbType)Enum.Parse(typeof(SqlDbType), paramTypeStr);
                        }
                        else
                        {
                            throw new Exception("파라미터 Type 오류 : " + paramName);
                        }
                        if (Enum.IsDefined(typeof(ParameterDirection), paramDirectStr))
                        {
                            paramDirect = (ParameterDirection)Enum.Parse(typeof(ParameterDirection), paramDirectStr);
                        }
                        else
                        {
                            throw new Exception("파라미터 Direction 오류 : " + paramName);
                        }

                        // 파라미터 추가
                        SelectParam.Add(paramName, paramDirect, 0, 0, 0, paramType, paramValue);
                    }

                    tableNames[c] = tableName;
                    selectSps[c] = selectSp;
                    paramStr[c] = SelectParam.Render();
                }

                // 서비스 호출
                if (service.Client == null)
                {
                    service.CreateProxy();
                }

                DataSet ds = new DataSet();
                service.Client.SelectDatas(ref ds, "", selectSps, paramStr);


                Dictionary<string, List<AjaxDictionary<string, object>>> dic = new Dictionary<string, List<AjaxDictionary<string, object>>>();
                for (int t = 0; t < ds.Tables.Count; t++)
                {
                    dic.Add(tableNames[t], Json.GetDataTableToList(ds.Tables[t]));
                }

                JsonDatas jds = new JsonDatas();
                jds.data = dic;
                jds.success = true;
                
                return jds;
            }
            catch (Exception exc)
            {
                string msg = exc.Message;
                if (exc.InnerException == null)
                {
                    try
                    {
                        ExceptionDetail innerException = ((FaultException<ExceptionDetail>)exc).Detail;

                        while (innerException != null)
                        {
                            if (innerException.InnerException.Type.ToUpper() == "SYSTEM.DATA.SQLCLIENT.SQLEXCEPTION")
                            {
                                msg = innerException.InnerException.Message;
                                break;
                            }
                            else
                            {
                                innerException = innerException.InnerException;
                            }
                        }
                    }
                    catch
                    {

                    }
                }

                JsonDatas jds = new JsonDatas();
                jds.success = false;
                jds.msg = msg;

                return jds;
            }
            finally
            {
                service.CloseProxy();
            }
        }
        #endregion

        #region Execute
        [OperationContract]
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest, ResponseFormat = WebMessageFormat.Json)]
        public JsonData Execute(string inputContent)
        {
            Mobile.Base.Service.Proxy service = new Mobile.Base.Service.Proxy();

            try
            {
                Dictionary<string, string> inputData = DecodeContent(inputContent);

                GST.Library.clsParamBuilder ExecuteParam = new clsParamBuilder(clsParamBuilder.BuilderParamType.ExecuteParameters);

                string selectSp = string.Empty;
                string paramJson = string.Empty;

                selectSp = inputData["SP"]; // 호출SP
                paramJson = inputData["PARAMS"];  // Parameters

                List<Dictionary<string, string>> paramData = JsonSerializer.DeserializeFromString<List<Dictionary<string, string>>>(paramJson);

                // Parameter 생성
                for (int i = 0; i < paramData.Count; i++)
                {
                    string paramName = "@" + paramData[i]["NAME"];
                    string paramTypeStr = paramData[i]["TYPE"];
                    string paramDirectStr = paramData[i]["DIRECTION"];
                    string paramValue = paramData[i]["VALUE"];

                    SqlDbType paramType = SqlDbType.VarChar;
                    ParameterDirection paramDirect = ParameterDirection.Input;

                    if (Enum.IsDefined(typeof(SqlDbType), paramTypeStr))
                    {
                        paramType = (SqlDbType)Enum.Parse(typeof(SqlDbType), paramTypeStr);
                    }
                    else
                    {
                        throw new Exception("파라미터 Type 오류 : " + paramName);
                    }
                    if (Enum.IsDefined(typeof(ParameterDirection), paramDirectStr))
                    {
                        paramDirect = (ParameterDirection)Enum.Parse(typeof(ParameterDirection), paramDirectStr);
                    }
                    else
                    {
                        throw new Exception("파라미터 Direction 오류 : " + paramName);
                    }

                    // 파라미터 추가
                    ExecuteParam.Add(paramName, paramDirect, 0, 0, 0, paramType, paramValue);

                }

                // 서비스 호출
                service.CreateProxy();

                int result = service.Client.Execute(selectSp, ExecuteParam.Render());
                
                JsonData jd = new JsonData();
                //if (result == -1)
                //{
                    jd.success = true;
                //}
                //else
                //{
                //    throw new Exception("실행에 실패했습니다.");
                //}

                return jd;
            }
            catch (Exception exc)
            {
                string msg = exc.Message;
                if (exc.InnerException == null)
                {
                    try
                    {
                        ExceptionDetail innerException = ((FaultException<ExceptionDetail>)exc).Detail;

                        while (innerException != null)
                        {
                            if (innerException.InnerException.Type.ToUpper() == "SYSTEM.DATA.SQLCLIENT.SQLEXCEPTION")
                            {
                                msg = innerException.InnerException.Message;
                                break;
                            }
                            else
                            {
                                innerException = innerException.InnerException;
                            }
                        }
                    }
                    catch
                    {

                    }
                }

                JsonData jd = new JsonData();
                jd.success = false;
                jd.msg = msg;

                return jd;
            }
            finally
            {
                service.CloseProxy();
            }

        }
        #endregion

        #region Save
        [OperationContract]
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest, ResponseFormat = WebMessageFormat.Json)]
        public JsonData Save(string inputContent)
        {
            Mobile.Base.Service.Proxy service = new Mobile.Base.Service.Proxy();

            try
            {
                Dictionary<string, string> inputData = DecodeContent(inputContent);

                //GST.Library.clsParamBuilder SaveParam;
                ParametersInfo SaveParam = new ParametersInfo();

                string saveGubun = inputData["SAVEGUBUN"];
                bool bInsert = false;
                bool bUpdate = false;
                bool bDelete = false;
                switch (saveGubun)
                {
                    case "I":
                        //SaveParam = new clsParamBuilder(clsParamBuilder.BuilderParamType.InsertParameters);
                        bInsert = true;
                        break;
                    case "U":
                        //SaveParam = new clsParamBuilder(clsParamBuilder.BuilderParamType.UpdateParameters);
                        bUpdate = true;
                        break;
                    case "D":
                        //SaveParam = new clsParamBuilder(clsParamBuilder.BuilderParamType.DeleteParameters);
                        bDelete = true;
                        break;
                    default:
                        throw new Exception("SAVE 구분이 정의되지 않았습니다.");
                }

                string insertSp = string.Empty;
                string deleteSp = string.Empty;
                string updateSp = string.Empty;
                string paramJson = string.Empty;

                insertSp = inputData["INSERTSP"]; // Insert SP
                deleteSp = inputData["DELETESP"]; // Delete SP
                updateSp = inputData["UPDATESP"]; // Update SP
                paramJson = inputData["PARAMS"];  // Parameters

                List<Dictionary<string, string>> paramData = JsonSerializer.DeserializeFromString<List<Dictionary<string, string>>>(paramJson);

                // Parameter 생성
                string strParam = "";
                strParam += saveGubun + "|" + Convert.ToChar(9).ToString();
                for (int i = 0; i < paramData.Count; i++)
                {
                    string paramName = "@" + paramData[i]["NAME"];
                    string paramTypeStr = paramData[i]["TYPE"];
                    string paramDirectStr = paramData[i]["DIRECTION"];
                    string paramValue = paramData[i]["VALUE"];

                    SqlDbType paramType = SqlDbType.VarChar;
                    ParameterDirection paramDirect = ParameterDirection.Input;

                    if (Enum.IsDefined(typeof(SqlDbType), paramTypeStr))
                    {
                        paramType = (SqlDbType)Enum.Parse(typeof(SqlDbType), paramTypeStr);
                    }
                    else
                    {
                        throw new Exception("파라미터 Type 오류 : " + paramName);
                    }
                    if (Enum.IsDefined(typeof(ParameterDirection), paramDirectStr))
                    {
                        paramDirect = (ParameterDirection)Enum.Parse(typeof(ParameterDirection), paramDirectStr);
                    }
                    else
                    {
                        throw new Exception("파라미터 Direction 오류 : " + paramName);
                    }

                    // 파라미터 추가
                    //SaveParam.Add(paramName, paramDirect, 0, 0, 0, paramType, paramValue);
                    SaveParam.Add(paramName, paramDirect, 0, 0, 0, paramType);

                    strParam += paramValue + "|" + Convert.ToChar(9).ToString();

                }
                strParam += "|" + Convert.ToChar(13).ToString();

                dzz_ucc_Parameters dzzParam = new dzz_ucc_Parameters();
                if (bInsert) dzzParam.InsertParameters = SaveParam;
                if (bDelete) dzzParam.DeleteParameters = SaveParam;
                if (bUpdate) dzzParam.UpdateParameters = SaveParam;

                // 서비스 호출
                service.CreateProxy();

                int result = service.Client.SaveData(insertSp, deleteSp, updateSp, dzzParam.CreateParametersFromString(strParam, bInsert, bDelete, bUpdate));

                JsonData jd = new JsonData();
                //if (result == -1)
                //{
                    jd.success = true;
                //}
                //else
                //{
                //    throw new Exception("저장에 실패했습니다.");
                //}

                return jd;
            }
            catch (Exception exc)
            {
                string msg = exc.Message;
                if (exc.InnerException == null)
                {
                    try
                    {
                        ExceptionDetail innerException = ((FaultException<ExceptionDetail>)exc).Detail;

                        while (innerException != null)
                        {
                            if (innerException.InnerException.Type.ToUpper() == "SYSTEM.DATA.SQLCLIENT.SQLEXCEPTION")
                            {
                                msg = innerException.InnerException.Message;
                                break;
                            }
                            else
                            {
                                innerException = innerException.InnerException;
                            }
                        }
                    }
                    catch
                    {

                    }
                }

                JsonData jd = new JsonData();
                jd.success = false;
                jd.msg = msg;

                return jd;
            }
            finally
            {
                service.CloseProxy();
            }
        }
        #endregion

        #region SaveOutput
        [OperationContract]
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest, ResponseFormat = WebMessageFormat.Json)]
        public JsonOutput SaveOutput(string inputContent)
        {
            Mobile.Base.Service.Proxy service = new Mobile.Base.Service.Proxy();

            try
            {
                Dictionary<string, string> inputData = DecodeContent(inputContent);

                //GST.Library.clsParamBuilder SaveParam;
                ParametersInfo SaveParam = new ParametersInfo();
                ParameterTypeEnum SaveEnum;
                string saveGubun = inputData["SAVEGUBUN"];
                bool bInsert = false;
                bool bUpdate = false;
                bool bDelete = false;
                switch (saveGubun)
                {
                    case "I":
                        //SaveParam = new clsParamBuilder(clsParamBuilder.BuilderParamType.InsertParameters);
                        SaveEnum = ParameterTypeEnum.Insert;
                        bInsert = true;
                        break;
                    case "U":
                        //SaveParam = new clsParamBuilder(clsParamBuilder.BuilderParamType.UpdateParameters);
                        SaveEnum = ParameterTypeEnum.Update;
                        bUpdate = true;
                        break;
                    case "D":
                        //SaveParam = new clsParamBuilder(clsParamBuilder.BuilderParamType.DeleteParameters);
                        SaveEnum = ParameterTypeEnum.Delete;
                        bDelete = true;
                        break;
                    default:
                        throw new Exception("SAVE 구분이 정의되지 않았습니다.");
                }

                string insertSp = string.Empty;
                string deleteSp = string.Empty;
                string updateSp = string.Empty;
                string paramJson = string.Empty;

                insertSp = inputData["INSERTSP"]; // Insert SP
                deleteSp = inputData["DELETESP"]; // Delete SP
                updateSp = inputData["UPDATESP"]; // Update SP
                paramJson = inputData["PARAMS"];  // Parameters

                List<Dictionary<string, string>> paramData = JsonSerializer.DeserializeFromString<List<Dictionary<string, string>>>(paramJson);

                // Parameter 생성
                string strParam = "";
                strParam += saveGubun + "|" + Convert.ToChar(9).ToString();
                for (int i = 0; i < paramData.Count; i++)
                {
                    string paramName = "@" + paramData[i]["NAME"];
                    string paramTypeStr = paramData[i]["TYPE"];
                    string paramDirectStr = paramData[i]["DIRECTION"];
                    int paramSize = Convert.ToInt32(paramData[i]["SIZE"]);
                    string paramValue = paramData[i]["VALUE"];

                    SqlDbType paramType = SqlDbType.VarChar;
                    ParameterDirection paramDirect = ParameterDirection.Input;

                    if (Enum.IsDefined(typeof(SqlDbType), paramTypeStr))
                    {
                        paramType = (SqlDbType)Enum.Parse(typeof(SqlDbType), paramTypeStr);
                    }
                    else
                    {
                        throw new Exception("파라미터 Type 오류 : " + paramName);
                    }
                    if (Enum.IsDefined(typeof(ParameterDirection), paramDirectStr))
                    {
                        paramDirect = (ParameterDirection)Enum.Parse(typeof(ParameterDirection), paramDirectStr);
                    }
                    else
                    {
                        throw new Exception("파라미터 Direction 오류 : " + paramName);
                    }

                    // 파라미터 추가
                    //SaveParam.Add(paramName, paramDirect, 0, 0, paramSize, paramType, paramValue);
                    SaveParam.Add(paramName, paramDirect, 0, 0, paramSize, paramType);

                    strParam += paramValue + "|" + Convert.ToChar(9).ToString();
                }
                strParam += "|" + Convert.ToChar(13).ToString();

                dzz_ucc_Parameters dzzParam = new dzz_ucc_Parameters();
                if (bInsert) dzzParam.InsertParameters = SaveParam;
                if (bDelete) dzzParam.DeleteParameters = SaveParam;
                if (bUpdate) dzzParam.UpdateParameters = SaveParam;

                // 서비스 호출
                service.CreateProxy();

                string outParam = dzzParam.CreateParametersFromString(strParam, bInsert, bDelete, bUpdate);
                int result = service.Client.SaveDataOut(insertSp, deleteSp, updateSp, ref outParam);
                string[] outStr = dzzParam.GetOutParamValue(outParam, SaveEnum);

                AjaxDictionary<string, object> dic = new AjaxDictionary<string, object>();
                //if (result == -1)
                //{
                    for (int i = 0; i < outStr.Length; i++)
                    {
                        dic.Add(paramData[i]["NAME"], outStr[i]);
                    }
                //}
                //else
                //{
                //    throw new Exception("저장에 실패했습니다.");
                //}

                JsonOutput jo = new JsonOutput();
                jo.data = dic;
                jo.success = true;

                return jo;
            }
            catch (Exception exc)
            {
                string msg = exc.Message;
                if (exc.InnerException == null)
                {
                    try
                    {
                        ExceptionDetail innerException = ((FaultException<ExceptionDetail>)exc).Detail;

                        while (innerException != null)
                        {
                            if (innerException.InnerException.Type.ToUpper() == "SYSTEM.DATA.SQLCLIENT.SQLEXCEPTION")
                            {
                                msg = innerException.InnerException.Message;
                                break;
                            }
                            else
                            {
                                innerException = innerException.InnerException;
                            }
                        }
                    }
                    catch
                    {

                    }
                }

                JsonOutput jo = new JsonOutput();
                jo.msg = msg;
                jo.success = true;

                return jo;
            }
            finally
            {
                service.CloseProxy();
            }

        }
        #endregion

        #region MultiSave
        [OperationContract]
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest, ResponseFormat = WebMessageFormat.Json)]
        public JsonData MultiSave(string inputContent)
        {
            Mobile.Base.Service.Proxy service = new Mobile.Base.Service.Proxy();

            try
            {
                List<string> arrData = DecodeContentList(inputContent);
                SaveDataParameterType[] strParamArray = new SaveDataParameterType[arrData.Count];

                for (int c = 0; c < arrData.Count; c++)
                {
                    Dictionary<string, string> inputData = JsonSerializer.DeserializeFromString<Dictionary<string, string>>(arrData[c]);

                    //GST.Library.clsParamBuilder SaveParam;
                    ParametersInfo SaveParam = new ParametersInfo();
                    string saveGubun = inputData["SAVEGUBUN"];
                    bool bInsert = false;
                    bool bUpdate = false;
                    bool bDelete = false;
                    switch (saveGubun)
                    {
                        case "I":
                            //SaveParam = new clsParamBuilder(clsParamBuilder.BuilderParamType.InsertParameters);
                            bInsert = true;
                            break;
                        case "U":
                            //SaveParam = new clsParamBuilder(clsParamBuilder.BuilderParamType.UpdateParameters);
                            bUpdate = true;
                            break;
                        case "D":
                            //SaveParam = new clsParamBuilder(clsParamBuilder.BuilderParamType.DeleteParameters);
                            bDelete = true;
                            break;
                        default:
                            throw new Exception(string.Format("SAVE 구분이 정의되지 않았습니다. [{0}]", c));
                    }

                    string insertSp = string.Empty;
                    string deleteSp = string.Empty;
                    string updateSp = string.Empty;
                    string paramJson = string.Empty;

                    insertSp = inputData["INSERTSP"]; // Insert SP
                    deleteSp = inputData["DELETESP"]; // Delete SP
                    updateSp = inputData["UPDATESP"]; // Update SP
                    paramJson = inputData["PARAMS"];  // Parameters

                    List<Dictionary<string, string>> paramData = JsonSerializer.DeserializeFromString<List<Dictionary<string, string>>>(paramJson);

                    // Parameter 생성
                    string strParam = "";
                    strParam += saveGubun + "|" + Convert.ToChar(9).ToString();
                    for (int i = 0; i < paramData.Count; i++)
                    {
                        string paramName = "@" + paramData[i]["NAME"];
                        string paramTypeStr = paramData[i]["TYPE"];
                        string paramDirectStr = paramData[i]["DIRECTION"];
                        string paramValue = paramData[i]["VALUE"];

                        SqlDbType paramType = SqlDbType.VarChar;
                        ParameterDirection paramDirect = ParameterDirection.Input;

                        if (Enum.IsDefined(typeof(SqlDbType), paramTypeStr))
                        {
                            paramType = (SqlDbType)Enum.Parse(typeof(SqlDbType), paramTypeStr);
                        }
                        else
                        {
                            throw new Exception(string.Format("파라미터 Type 오류 : " + paramName + " [{0}]", c));
                        }
                        if (Enum.IsDefined(typeof(ParameterDirection), paramDirectStr))
                        {
                            paramDirect = (ParameterDirection)Enum.Parse(typeof(ParameterDirection), paramDirectStr);
                        }
                        else
                        {
                            throw new Exception(string.Format("파라미터 Direction 오류 : " + paramName + " [{0}]", c));
                        }

                        // 파라미터 추가
                        //SaveParam.Add(paramName, paramDirect, 0, 0, 0, paramType, paramValue); 
                        SaveParam.Add(paramName, paramDirect, 0, 0, 0, paramType);

                        strParam += paramValue + "|" + Convert.ToChar(9).ToString();
                    }
                    strParam += "|" + Convert.ToChar(13).ToString();

                    strParamArray[c] = new SaveDataParameterType();
                    dzz_ucc_Parameters dzzParam = new dzz_ucc_Parameters();
                    if (bInsert)
                    {
                        dzzParam.InsertParameters = SaveParam;
                        strParamArray[c].InsertSP = insertSp;
                    }
                    if (bDelete)
                    {
                        dzzParam.DeleteParameters = SaveParam;
                        strParamArray[c].DeleteSP = deleteSp;
                    }
                    if (bUpdate)
                    {
                        dzzParam.UpdateParameters = SaveParam;
                        strParamArray[c].UpdateSP = updateSp;
                    }

                    strParamArray[c].XmlParameter = dzzParam.CreateParametersFromString(strParam, bInsert, bDelete, bUpdate);
                }

                // 서비스 호출
                if (service.Client == null)
                {
                    service.CreateProxy();
                }

                int result = service.Client.SaveDatas(strParamArray);

                if (result != strParamArray.Length)
                {
                    throw new Exception("저장에 실패했습니다.");
                }

                JsonData jd = new JsonData();
                jd.success = true;

                return jd;
            }
            catch (Exception exc)
            {
                string msg = exc.Message;
                if (exc.InnerException == null)
                {
                    try
                    {
                        ExceptionDetail innerException = ((FaultException<ExceptionDetail>)exc).Detail;

                        while (innerException != null)
                        {
                            if (innerException.InnerException.Type.ToUpper() == "SYSTEM.DATA.SQLCLIENT.SQLEXCEPTION")
                            {
                                msg = innerException.InnerException.Message;
                                break;
                            }
                            else
                            {
                                innerException = innerException.InnerException;
                            }
                        }
                    }
                    catch
                    {

                    }
                }
                JsonData jd = new JsonData();
                jd.success = false;
                jd.msg = msg;

                return jd;
            }
            finally
            {
                service.CloseProxy();
            }

        }
        #endregion

        #endregion

        #region File

        #region FileList
        [OperationContract]
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest, ResponseFormat = WebMessageFormat.Json)]
        public JsonData FileList(string inputContent)
        {
            try
            {
                byte[] byteBase64 = StringHelper.FromBase64(inputContent);
                string decodeBase64 = StringHelper.UTF8BytesToString(byteBase64);

                Dictionary<string, string> jsonData = JsonSerializer.DeserializeFromString<Dictionary<string, string>>(decodeBase64);
                string path = jsonData["DATA"];

                string FileRoot = System.Configuration.ConfigurationManager.AppSettings["FILE_PATH"].ToString();
                string FilePath = path.Replace("/", "\\");
                string FileFullPath = FileRoot + FilePath;


                List<AjaxDictionary<string, object>> rows = new List<AjaxDictionary<string, object>>();
                if (Directory.Exists(FileFullPath))
                {
                    string[] files = Directory.GetFiles(FileFullPath);
                    foreach (string file in files)
                    {
                        FileInfo fileInfo = new FileInfo(file);
                        AjaxDictionary<string, object> row = new AjaxDictionary<string, object>();
                        row.Add("path", path);
                        row.Add("name", fileInfo.Name);

                        rows.Add(row);
                    }
                }

                JsonData jd = new JsonData();
                jd.data = rows;
                jd.success = true;

                return jd;
            }
            catch (Exception ex)
            {
                JsonData jd = new JsonData();
                jd.success = false;
                jd.msg = ex.Message;

                return jd;
            }
        }
        #endregion

        #region FileUpload
        [OperationContract]
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest, ResponseFormat = WebMessageFormat.Json)]
        public JsonData FileUpload(string path, string name, string size, string type, string data)
        {
            JsonData jd = new JsonData();

            try
            {
                string ext = name.Substring(name.LastIndexOf('.')).ToLower();
                string fileName = DateTime.Now.ToString("yyyyMMddHHmmssfff") + ext;
                string fileRoot = System.Configuration.ConfigurationManager.AppSettings["FILE_PATH"].ToString();
                string fileDir = fileRoot + path.Replace("/", "\\");
                string fileFullPath = fileDir + "\\" + fileName;

                if (!Directory.Exists(fileDir))
                {
                    Directory.CreateDirectory(fileDir);
                }

                int cnt = 1;
                while (File.Exists(fileFullPath))
                {
                    fileName = DateTime.Now.ToString("yyyyMMddHHmmssfff_") + cnt.ToString() + ext;
                    fileFullPath = fileDir + "\\" + fileName;
                    cnt++;
                }

                FileStream fs = new FileStream(fileFullPath, FileMode.Create);
                BinaryWriter bw = new BinaryWriter(fs);

                try
                {
                    byte[] newImg = getResizedImage(StringHelper.FromBase64(data), ext, 800, 600);

                    bw.Write(newImg);

                    jd.msg = fileName;
                    jd.success = true;
                }
                catch (Exception fex)
                {
                    jd.msg = fex.Message;
                    jd.success = false;
                }
                finally
                {
                    fs.Close();
                    bw.Close();
                }
            }
            catch (Exception ex)
            {
                jd.msg = ex.Message;
                jd.success = false;
            }

            return jd;
        }

        byte[] getResizedImage(byte[] data, string ext, int width, int height)
        {
            Bitmap imgIn = new Bitmap(new MemoryStream(data));
            double y = imgIn.Height;
            double x = imgIn.Width;

            double factor = 1;
            if (width > 0)
            {
                factor = width / x;
            }
            else if (height > 0)
            {
                factor = height / y;
            }
            System.IO.MemoryStream outStream = new System.IO.MemoryStream();
            Bitmap imgOut = new Bitmap((int)(x * factor), (int)(y * factor));

            // Set DPI of image (xDpi, yDpi)
            imgOut.SetResolution(72, 72);

            Graphics g = Graphics.FromImage(imgOut);
            g.Clear(Color.White);
            g.DrawImage(imgIn, new Rectangle(0, 0, (int)(factor * x), (int)(factor * y)),
              new Rectangle(0, 0, (int)x, (int)y), GraphicsUnit.Pixel);

            imgOut.Save(outStream, getImageFormat(ext));
            return outStream.ToArray();
        }

        string getContentType(String ext)
        {
            switch (ext)
            {
                case ".bmp": return "Image/bmp";
                case ".gif": return "Image/gif";
                case ".jpg": return "Image/jpeg";
                case ".png": return "Image/png";
                default: break;
            }
            return "";
        }

        ImageFormat getImageFormat(String ext)
        {
            switch (ext)
            {
                case ".bmp": return ImageFormat.Bmp;
                case ".gif": return ImageFormat.Gif;
                case ".jpg": return ImageFormat.Jpeg;
                case ".png": return ImageFormat.Png;
                default: break;
            }
            return ImageFormat.Jpeg;
        }
        #endregion

        #endregion

    }


}
