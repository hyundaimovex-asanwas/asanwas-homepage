  package transfer;

/**
 * <p>Title: Excel Data Read</p>
 * <p>Description: ���������� �о Vector�� Return</p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */
 
import java.io.*;
import java.io.InputStream.*;
import java.io.IOException.*;
import java.io.ByteArrayInputStream.*;
import java.io.FileInputStream.*;
import java.io.FileOutputStream.*;
import java.util.*;
import java.lang.Object.*;

import  javax.servlet.*;
import  javax.servlet.http.*;
 
import java.text.DecimalFormat;

import org.apache.poi.poifs.filesystem.*;
import org.apache.poi.poifs.filesystem.POIFSFileSystem.*;
import org.apache.poi.poifs.dev.*;
import org.apache.poi.hssf.record.*;
import org.apache.poi.hssf.record.formula.*;
import org.apache.poi.hssf.model.*;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.*;

import java.awt.*;

public class CommonExcel extends HttpServlet
{


  public void init(ServletConfig config) throws ServletException
    {
        super.init(config);
    }


  public static Vector getExcelData() {
    
	Vector vData = new Vector();

    int sheetNum = 0;
    HSSFWorkbook wb = null;
    HSSFSheet sheet = null;
    HSSFRow row = null;
    HSSFCell cell = null;
    String value = null;

    String filename;

    ///////////////////////////////
    // ȭ�� ���̾�α� �ڽ��� ���½�Ų��.
    DoFileDialog fd = new DoFileDialog(null, "Open a File");


    // ȭ���� ������ �Ǿ��� ���
    filename=fd.getPath() + fd.getFileName();
    System.out.println("���� �̸� : " + filename);

    try {
      POIFSFileSystem fs = new POIFSFileSystem(new FileInputStream(filename));
      wb = new HSSFWorkbook(fs);

      sheet = wb.getSheetAt(0);
	  
      int rows = sheet.getPhysicalNumberOfRows();
System.out.println("ROW:" + rows) ; 
 
      for (int r =20 ;r <rows ; r++) {
        row = sheet.getRow(r);

        int cells = row.getPhysicalNumberOfCells();
        String[] a =new  String[cells];

        for(int q=0 ;q<cells ; q++) {
          
		  cell = row.getCell((short)q);
		  //System.out.println("cell:" + cell) ; 
		  if(cell != null ){
          switch(cell.getCellType())
          {
            //���� ���� ������ ��
            case HSSFCell.CELL_TYPE_NUMERIC :
              DecimalFormat df = new DecimalFormat("########################");
              a[q] = df.format(cell.getNumericCellValue());
              break;
              //���� ���� ������ ��
            case HSSFCell.CELL_TYPE_STRING :
              a[q]=cell.getStringCellValue();
              break;
            case HSSFCell.CELL_TYPE_BLANK :
              System.out.println("row:"+Integer.toString(r)+"  col:"+Integer.toString(q)+"  data: blank");
			  a[q] = "" ; 
              break;
            case HSSFCell.CELL_TYPE_BOOLEAN :
				a[q] = "" ; 
              break;
            case HSSFCell.CELL_TYPE_ERROR :
				a[q] = "" ; 
              break;
            default:
				a[q] = "" ; 
              break ;
          }
        }else{ a[q]  = "" ; }}
        vData.addElement(a);
      }

    } catch(Exception e) {
      System.out.println("e : "+e.toString());
    }
    return vData;
  }

  public void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
			
			response.setContentType("text/plain;charset=euc-kr");
				 PrintWriter out = response.getWriter();
				 //out.println("Hey, don't call by GET Method");
				 //out.close();
			try{
				CommonExcel commonExcel = new CommonExcel();
				Vector vData2 = new Vector();
				int cnt;
				vData2 = commonExcel.getExcelData();
				cnt = vData2.size();
				try{

						System.out.println("cnt "+Integer.toString(cnt));
						for(int i=0;i<cnt;i++){
						  String[] a = (String[]) vData2.elementAt(i);
								  for(int j=0;j<a.length;j++){
									System.out.println("data "+Integer.toString(i)+":"+Integer.toString(j)+": "+a[j]);
								  }
						 }
				}
				catch ( Exception e ) 
				{
					out.println(e.toString());
				}}
			catch ( Exception e ) 
				{
					out.println(e.toString());
				} }
	 
}

// ȭ�� ���̾�α� ���� �� ó���� ���� Ŭ����
  class DoFileDialog
  {
    FileDialog fd;
    Frame f = null;

    // ȭ�� ���̾�α� ������.
    public DoFileDialog(Frame parent, String title, int mode) throws AWTError
    {
      if(parent == null)
      {
        f = new Frame(title);
        f.pack();
        fd = new FileDialog(f, title, mode);
      }else{
        fd = new FileDialog(parent, title, mode);
      }

      if(mode == FileDialog.LOAD){
        fd.setFile("*.xls");
      }
      fd.show();
      if(f != null){
        f.dispose();
      }
    }

    public DoFileDialog(Frame parent, String title)
    {
      this(parent, title, FileDialog.LOAD);
    }

    // ȭ�� ���̾�α׿��� ���õ� ������ �̸��� ��ȯ�Ѵ�.
    String getFileName()
    {
      if(fd != null && fd.getDirectory() != null && fd.getFile() != null)
        return fd.getFile();
      return null;
    }

    // ȭ�� ���̾�α׿��� ���õ� ������ ���丮�� ��ȯ�Ѵ�.
    String getPath()
    {
      if(fd != null && fd.getDirectory() != null && fd.getFile() != null)
        return fd.getDirectory();
      return null;
    }
  }