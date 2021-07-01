using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Security.Cryptography;

using ServiceStack.Text;
using Mobile.Base.Web;
using Mobile.Base.Data;
using Mobile.Base.Util;

namespace Mobile.model
{
    public partial class Ajax_File_Upload : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Clear();
            //Response.ContentType = "application/json; charset=utf-8";

            if (!UserInfo.IsLogin())
            {
                string json = "{ \"success\" : false, \"msg\" : \"로그인 정보가 없습니다.\" }";
                //byte[] o = StringHelper.UTF8StringToBytes(json);

                //Response.Write(StringHelper.ToBase64(o));
                Response.Write(json);
                Response.End();
            }

            if ( Request.QueryString["PATH"] != null)
            {
                string path = Request.QueryString["PATH"].ToString();

                FileProcess(path);
            }
        }

        private void FileProcess(string path)
        {
            try
            {
                string fileRoot = System.Configuration.ConfigurationManager.AppSettings["FILE_PATH"].ToString();
                string fileDir = fileRoot + path.Replace("/", "\\");

                if (!Directory.Exists(fileDir))
                {
                    Directory.CreateDirectory(fileDir);
                }

                int cnt = 1;

                if (Request.Files.Count > 0)
                {
                    HttpFileCollection upload = Request.Files;

                    string msg = "";
                    if (upload.AllKeys.Contains<string>("file1"))
                    {
                        string fileName = upload["file1"].FileName;
                        fileName = fileName.Substring(fileName.LastIndexOf("\\") + 1);
                        int fileSize = upload["file1"].ContentLength;
                        string fileExt = fileName.Substring(fileName.LastIndexOf(".")).ToLower();

                        string fileFullPath = fileDir + "\\" + fileName;

                        while (File.Exists(fileFullPath))
                        {
                            fileName = DateTime.Now.ToString("yyyyMMddHHmmssfff_") + cnt.ToString() + fileExt;
                            fileFullPath = fileDir + "\\" + fileName;
                            cnt++;
                        }

                        if (!Directory.Exists(fileDir))
                        {
                            Directory.CreateDirectory(fileDir);
                        }

                        // 파일저장
                        upload["file1"].SaveAs(fileFullPath);
                        msg += fileName;
                    }
                    msg += "/";

                    if (upload.AllKeys.Contains<string>("file2"))
                    {
                        string fileName = upload["file2"].FileName;
                        fileName = fileName.Substring(fileName.LastIndexOf("\\") + 1);
                        int fileSize = upload["file2"].ContentLength;
                        string fileExt = fileName.Substring(fileName.LastIndexOf(".")).ToLower();

                        string fileFullPath = fileDir + "\\" + fileName;

                        while (File.Exists(fileFullPath))
                        {
                            fileName = DateTime.Now.ToString("yyyyMMddHHmmssfff_") + cnt.ToString() + fileExt;
                            fileFullPath = fileDir + "\\" + fileName;
                            cnt++;
                        }

                        if (!Directory.Exists(fileDir))
                        {
                            Directory.CreateDirectory(fileDir);
                        }

                        // 파일저장
                        upload["file2"].SaveAs(fileFullPath);

                        msg += fileName;
                    }

                    
                    JsonData jd = new JsonData();
                    jd.msg = msg;
                    jd.success = true;

                    string json = JsonSerializer.SerializeToString(jd);

                    Response.Write(json);
                }
            }
            catch (Exception ex)
            {
                JsonData jd = new JsonData();
                jd.msg = ex.Message;
                jd.success = false;

                string json = JsonSerializer.SerializeToString(jd);

                Response.Write(json);

            }
            finally
            {
                Response.End();
            }
        }

    }
}
