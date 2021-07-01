package pms.news.bud.excel;

//import Ehr.wel.n.Bud025ExcelCMD.dao.Bud025ExcelCMDDAO;
//import pms.news.bud.excel.Bud025ExcelDAO;

import java.io.FileInputStream;
import java.io.InputStream;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;




import org.apache.poi.poifs.filesystem.POIFSFileSystem;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.BizException;
import com.shift.gef.core.exception.CException;
import com.shift.gef.core.log.Log;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

import Ehr.but.a.buta020.dao.BUTA020DAO;
import Ehr.common.util.CommUtil;
import Ehr.common.util.FileUtil;
import Ehr.common.util.POIUtil;
import Ehr.common.util.POIUtilXlsx;

public class Bud025ExcelWRK {

	/**
	 * ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void Bud025ExcelCMD_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** WELJ030DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		Bud025ExcelDAO dao = new Bud025ExcelDAO("default", p_tr);
		dao.Bud025ExcelCMD_SHR(p_box);

	}


	/**
	 * ������ �����ϱ� ���� WORK�޼ҵ� ȣ��
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void Bud025ExcelCMD_DEL(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("ds_default");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		Bud025ExcelDAO dao = new Bud025ExcelDAO("default", p_tr);
		Bud025ExcelDAO dao2 = new Bud025ExcelDAO("default", p_tr);
		
		dao.Bud025ExcelCMD_DEL(p_box);
		dao2.Bud025ExcelCMD_DEL2(p_box);


	}


    /**
     * EXCEL ���� ���ε�  - Ȯ���ڸ� : xls
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void Bud025Excel1CMD_ULD( CBox p_box, TrBox p_tr ) throws CException {

        InputStream is = FileUtil.getFileStream(p_tr, "dsFILE_UPLOAD", "FILE_URL")[0];
        System.out.println("xls  is????????"+is);
        System.out.println("xls �����̴�...�Ф�");

        
        System.out.println("xls �����̴�1111111111111111...�Ф�");        
        
        
        String resultMsg = "";

        //�������� ������ ��� ���� �����ͼ�
        GauceDataSet ds = new GauceDataSet();
        GauceDataRow dr = null;

        ds.addDataColumn(new GauceDataColumn("DS_KSITEM1",  GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("DS_KSITEM2",  GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("DS_KSITEM3",  GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("DS_KSITEM4",  GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("CD_COST",  GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("COST_YN",  GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("ORDER_AMT", GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("EXE_ACT_QN", GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("EXE_ACT_UP", GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("EXE_ACT_AMT", GauceDataColumn.TB_STRING ));
        
        
        
        
        
      /*  ds.addDataColumn(new GauceDataColumn("ORDER_QN", GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("ORDER_UP",  GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("PRO_ACT_QN", GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("PRO_ACT_UP", GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("PRO_ACT_AMT", GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("BID_ACT_QN", GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("BID_ACT_UP", GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("BID_ACT_AMT", GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("ITEM_CD", GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("ITEM_NM", GauceDataColumn.TB_STRING ));*/

        HSSFWorkbook workbook = null;
        HSSFSheet sheet = null;
        HSSFRow row = null;

        try{
            //��ũ���� ����!
            workbook = new HSSFWorkbook(new POIFSFileSystem(is));
            //��Ʈ �̸��� ��Ʈ��ȣ�� ����
            sheet = workbook.getSheetAt(0);//ù��° ��Ʈ
            row     = null;
            System.out.println("xls  try!");

        }catch(Exception e) {
            Log.err.println(e.getMessage());
            System.out.println("xls  1?");
        }

        if(sheet != null) {

            //HEADER �κ� �ǳʶ� INDEX 1���� ����
            for (int i = 1; i < sheet.getPhysicalNumberOfRows(); i++) {
            	System.out.println("xls  sheet != null �̸� �����ؾ���!?");

                // ��Ʈ�� ���� ���� �ϳ��� ����
                row = sheet.getRow(i);

                /*if(row.getPhysicalNumberOfCells() != 1)
                    throw new BizException("xls  ���������� ���� ������ 1���̾�� �մϴ�!");*/
                try {
                    dr = new GauceDataRow(ds.getDataColCnt());

                    dr.setString( 0, POIUtil.getString(row, 0));
                    dr.setString( 1, POIUtil.getString(row, 1));
                    dr.setString( 2, POIUtil.getString(row, 2));
                    dr.setString( 3, POIUtil.getString(row, 3));
                    dr.setString( 4, POIUtil.getString(row, 4));
                    dr.setString( 5, POIUtil.getString(row, 5));
                    dr.setString( 6, POIUtil.getString(row, 6));
                    dr.setString( 7, POIUtil.getString(row, 7));
                    dr.setString( 8, POIUtil.getString(row, 8));
                    dr.setString( 9, POIUtil.getString(row, 9));
                    /*dr.setString( 10, POIUtil.getString(row, 10));
                    dr.setString( 11, POIUtil.getString(row, 11));
                    dr.setString( 12, POIUtil.getString(row, 12));
                    dr.setString( 13, POIUtil.getString(row, 13));
                    dr.setString( 14, POIUtil.getString(row, 14));
                    dr.setString( 15, POIUtil.getString(row, 15));
                    dr.setString( 16, POIUtil.getString(row, 16));*/

                    ds.addDataRow(dr);
                  

                } catch (Exception e) {
                    resultMsg += e.getMessage();
                    System.out.println("xls sheet != null catch �κ�..�Ф�");
                }
                System.out.println("22");
            }
            System.out.println("33");
        }
        System.out.println("44");

        p_tr.setOutDataSet("ds_default", ds);
        System.out.println("xls  ���� �����Ծ��~~~~~~~~~");
        p_tr.setOutDataSet("dsRESULT", CommUtil.getResultDataSet("RESULT_MSG", resultMsg));
        System.out.println("xls  �����???");

    }
    
    
    /**
     * EXCEL ���� ���ε� - Ȯ���ڸ� : xlsx
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void Bud025Excel2CMD_ULD( CBox p_box, TrBox p_tr ) throws CException {

        InputStream is = FileUtil.getFileStream(p_tr, "dsFILE_UPLOAD", "FILE_URL")[0];
        System.out.println("xlsx  is????????"+is);
        System.out.println("Bud025ExcelWRK       xlsx Start@@@@");

        String resultMsg = "";

        //�������� ������ ��� ���� �����ͼ�
        GauceDataSet ds = new GauceDataSet();
        GauceDataRow dr = null;
        
        
        
        
        ds.addDataColumn(new GauceDataColumn("DS_KSITEM1",  GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("DS_KSITEM2",  GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("DS_KSITEM3",  GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("DS_KSITEM4",  GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("CD_COST",  GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("COST_YN",  GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("ORDER_AMT", GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("EXE_ACT_QN", GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("EXE_ACT_UP", GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("EXE_ACT_AMT", GauceDataColumn.TB_STRING ));
        

        /*ds.addDataColumn(new GauceDataColumn("DS_KSITEM",  GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("CD_COST",  GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("COST_YN",  GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("ORDER_QN", GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("ORDER_UP",  GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("ORDER_AMT", GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("PRO_ACT_QN", GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("PRO_ACT_UP", GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("PRO_ACT_AMT", GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("BID_ACT_QN", GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("BID_ACT_UP", GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("BID_ACT_AMT", GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("EXE_ACT_QN", GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("EXE_ACT_UP", GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("EXE_ACT_AMT", GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("ITEM_CD", GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("ITEM_NM", GauceDataColumn.TB_STRING ));*/

        /*HSSFWorkbook workbook = null;
        HSSFSheet sheet = null;
        HSSFRow row = null;
        System.out.println("2");*/
        
        XSSFWorkbook workbook = null;
        XSSFSheet sheet = null;
        XSSFRow row = null;

        try{
            //��ũ���� ����!
        	//workbook = new HSSFWorkbook(new POIFSFileSystem(is));
            //workbook = new XSSFWorkbook(new POIFSFileSystem(is));
            //workbook = new XSSFWorkbook(new  FileInputStream(is));
        	//workbook = new XSSFWorkbook(new POIFSFileSystem(is));
        	//XSSFWorkbook workBook  =  new XSSFWorkbook(new FileInputStream(new File(filePath)));
        	System.out.println("��������Ծ�..�ФФФ�");
        	
        	
        	//workbook = new XSSFWorkbook(is);
        	workbook = new XSSFWorkbook(is);
        	System.out.println("����Դ�??�ФФФФФФФ�");
        	
          
            
            //workbook2 = new XSSFWorkbook(new POIFSFileSystem(is));
            //��Ʈ �̸��� ��Ʈ��ȣ�� ����
            sheet = workbook.getSheetAt(0);//ù��° ��Ʈ
            row     = null;
            System.out.println("xlsx  try!");

        }catch(Exception e) {
            Log.err.println(e.getMessage());
            System.out.println("xlsx  1?");
        }

        if(sheet != null) {
        	System.out.println("111111");

            //HEADER �κ� �ǳʶ� INDEX 1���� ����
            for (int i = 1; i < sheet.getPhysicalNumberOfRows(); i++) {
            	System.out.println("xlsx  sheet != null �̸� �����ؾ���!?");

                // ��Ʈ�� ���� ���� �ϳ��� ����
                row = sheet.getRow(i);

         /*       if(row.getPhysicalNumberOfCells() != 1)
                    throw new BizException("xlsx  ���������� ���� ������ 1234���̾�� �մϴ�!");*/
                try {
                    dr = new GauceDataRow(ds.getDataColCnt());

                    dr.setString( 0, POIUtilXlsx.getString(row, 0));
                    dr.setString( 1, POIUtilXlsx.getString(row, 1));
                    dr.setString( 2, POIUtilXlsx.getString(row, 2));
                    dr.setString( 3, POIUtilXlsx.getString(row, 3));
                    dr.setString( 4, POIUtilXlsx.getString(row, 4));
                    dr.setString( 5, POIUtilXlsx.getString(row, 5));
                    dr.setString( 6, POIUtilXlsx.getString(row, 6));
                    dr.setString( 7, POIUtilXlsx.getString(row, 7));
                    dr.setString( 8, POIUtilXlsx.getString(row, 8));
                    dr.setString( 9, POIUtilXlsx.getString(row, 9));

                    ds.addDataRow(dr);
                  

                } catch (Exception e) {
                    resultMsg += e.getMessage();
                    System.out.println("xlsx  sheet != null catch �κ�..�Ф�");
                }
            }
        }

        p_tr.setOutDataSet("ds_default", ds);
        System.out.println("xlsx  ���� �����Ծ��~~~~~~~~~");
        p_tr.setOutDataSet("dsRESULT", CommUtil.getResultDataSet("RESULT_MSG", resultMsg));
        System.out.println("xlsx  �������???");

    }


	/**
	 * ������ �����ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void Bud025ExcelCMD_SAV(CBox p_box, TrBox p_tr) throws CException {

        String resultMsg = "";
        int err_cnt = 0;
        System.out.println("Bud025ExcelCMD_SAV@@@@@@@@@@@@");

		GauceValueObject voList = p_tr.getInGauceValueObject("ds_default");
        GauceValueObject vo = null;

        Bud025ExcelDAO dao = new Bud025ExcelDAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {
			vo = voList.get(i);

            try {
                this.Bud025ExcelCMD_SAV(vo, p_box, p_tr);
            } catch(CException e) {
                err_cnt++;
            }
		}

		if(err_cnt>0){
			resultMsg = "��ü "+voList.size()+"�� �� "+err_cnt+"���� ����� �����Ͽ����ϴ�.";
		}else{
			resultMsg = "��ü "+voList.size()+"���� ����� �����Ͽ����ϴ�.";
		}

        p_tr.setOutDataSet("dsRESULT", CommUtil.getResultDataSet("RESULT_MSG", resultMsg));
	}


	public void Bud025ExcelCMD_SAV(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		Bud025ExcelDAO dao = new Bud025ExcelDAO("default", p_tr);

		dao.Bud025ExcelCMD_SAV(vo, p_box);

	}		
	
	
	
	/**
	 * ������ ���� �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void Bud025ExcelCMD_SAV_01(CBox p_box, TrBox p_tr) throws CException {

        String resultMsg = "";
        int err_cnt = 0;

		GauceValueObject voList = p_tr.getInGauceValueObject("ds_default");
        GauceValueObject vo = null;

        Bud025ExcelDAO dao = new Bud025ExcelDAO("default", p_tr);

        dao.Bud025ExcelCMD_SAV_01(vo, p_box);

		if(err_cnt>0){
			resultMsg = "��ü "+voList.size()+"�� �� "+err_cnt+"���� ����� �����Ͽ����ϴ�.";
		}else{
			resultMsg = "��ü "+voList.size()+"���� ����� �����Ͽ����ϴ�.";
		}

        p_tr.setOutDataSet("dsRESULT", CommUtil.getResultDataSet("RESULT_MSG", resultMsg));
	}

	/**
	 * ���� �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void Bud025ExcelCMD_SAV_END(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("ds_default");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		Bud025ExcelDAO dao = new Bud025ExcelDAO("default", p_tr);

		dao.Bud025ExcelCMD_SAV_END(p_box);

	}



}

