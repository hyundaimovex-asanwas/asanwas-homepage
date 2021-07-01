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
	 * 繕噺馬澗 WRK 五社球
	 * @param p_box		CBox梓端 (Request/Session舛左研 眼精 梓端)
	 * @param p_tr		    TrBox梓端 (亜酔什 陳匂獲闘人 I/O呪楳)
	 * @throws CException
	 */
	public void Bud025ExcelCMD_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** WELJ030DAO 梓端 持失 板 淫恵 五社球 硲窒 */
		Bud025ExcelDAO dao = new Bud025ExcelDAO("default", p_tr);
		dao.Bud025ExcelCMD_SHR(p_box);

	}


	/**
	 * 舛左研 肢薦馬奄 是廃 WORK五社球 硲窒
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void Bud025ExcelCMD_DEL(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet梓端研 GauceValueObject稽 痕発馬食 坦軒 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("ds_default");

		/** 闘沓詮芝聖 呪楳馬奄 是背辞 getConnection(false)稽 竺舛 **/
		Bud025ExcelDAO dao = new Bud025ExcelDAO("default", p_tr);
		Bud025ExcelDAO dao2 = new Bud025ExcelDAO("default", p_tr);
		
		dao.Bud025ExcelCMD_DEL(p_box);
		dao2.Bud025ExcelCMD_DEL2(p_box);


	}


    /**
     * EXCEL 督析 穣稽球  - 溌舌切誤 : xls
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void Bud025Excel1CMD_ULD( CBox p_box, TrBox p_tr ) throws CException {

        InputStream is = FileUtil.getFileStream(p_tr, "dsFILE_UPLOAD", "FILE_URL")[0];
        System.out.println("xls  is????????"+is);
        System.out.println("xls 獣拙戚陥...ばば");

        
        System.out.println("xls 獣拙戚陥1111111111111111...ばば");        
        
        
        String resultMsg = "";

        //植漆督析 舛左研 眼奄 是廃 汽戚斗実
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
            //趨滴栽聖 持失!
            workbook = new HSSFWorkbook(new POIFSFileSystem(is));
            //獣闘 戚硯引 獣闘腰硲研 蓄窒
            sheet = workbook.getSheetAt(0);//湛腰属 獣闘
            row     = null;
            System.out.println("xls  try!");

        }catch(Exception e) {
            Log.err.println(e.getMessage());
            System.out.println("xls  1?");
        }

        if(sheet != null) {

            //HEADER 採歳 闇格芹 INDEX 1採斗 獣拙
            for (int i = 1; i < sheet.getPhysicalNumberOfRows(); i++) {
            	System.out.println("xls  sheet != null 戚檎 獣拙背醤背!?");

                // 獣闘拭 企廃 楳聖 馬蟹梢 蓄窒
                row = sheet.getRow(i);

                /*if(row.getPhysicalNumberOfCells() != 1)
                    throw new BizException("xls  植漆督析税 漆税 姐呪澗 1鯵戚嬢醤 杯艦陥!");*/
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
                    System.out.println("xls sheet != null catch 採歳..ばば");
                }
                System.out.println("22");
            }
            System.out.println("33");
        }
        System.out.println("44");

        p_tr.setOutDataSet("ds_default", ds);
        System.out.println("xls  食奄 猿走尽嬢推~~~~~~~~~");
        p_tr.setOutDataSet("dsRESULT", CommUtil.getResultDataSet("RESULT_MSG", resultMsg));
        System.out.println("xls  食奄澗???");

    }
    
    
    /**
     * EXCEL 督析 穣稽球 - 溌舌切誤 : xlsx
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void Bud025Excel2CMD_ULD( CBox p_box, TrBox p_tr ) throws CException {

        InputStream is = FileUtil.getFileStream(p_tr, "dsFILE_UPLOAD", "FILE_URL")[0];
        System.out.println("xlsx  is????????"+is);
        System.out.println("Bud025ExcelWRK       xlsx Start@@@@");

        String resultMsg = "";

        //植漆督析 舛左研 眼奄 是廃 汽戚斗実
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
            //趨滴栽聖 持失!
        	//workbook = new HSSFWorkbook(new POIFSFileSystem(is));
            //workbook = new XSSFWorkbook(new POIFSFileSystem(is));
            //workbook = new XSSFWorkbook(new  FileInputStream(is));
        	//workbook = new XSSFWorkbook(new POIFSFileSystem(is));
        	//XSSFWorkbook workBook  =  new XSSFWorkbook(new FileInputStream(new File(filePath)));
        	System.out.println("食奄猿走尽嬢..ばばばば");
        	
        	
        	//workbook = new XSSFWorkbook(is);
        	workbook = new XSSFWorkbook(is);
        	System.out.println("食奄尽艦??ばばばばばばばば");
        	
          
            
            //workbook2 = new XSSFWorkbook(new POIFSFileSystem(is));
            //獣闘 戚硯引 獣闘腰硲研 蓄窒
            sheet = workbook.getSheetAt(0);//湛腰属 獣闘
            row     = null;
            System.out.println("xlsx  try!");

        }catch(Exception e) {
            Log.err.println(e.getMessage());
            System.out.println("xlsx  1?");
        }

        if(sheet != null) {
        	System.out.println("111111");

            //HEADER 採歳 闇格芹 INDEX 1採斗 獣拙
            for (int i = 1; i < sheet.getPhysicalNumberOfRows(); i++) {
            	System.out.println("xlsx  sheet != null 戚檎 獣拙背醤背!?");

                // 獣闘拭 企廃 楳聖 馬蟹梢 蓄窒
                row = sheet.getRow(i);

         /*       if(row.getPhysicalNumberOfCells() != 1)
                    throw new BizException("xlsx  植漆督析税 漆税 姐呪澗 1234鯵戚嬢醤 杯艦陥!");*/
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
                    System.out.println("xlsx  sheet != null catch 採歳..ばば");
                }
            }
        }

        p_tr.setOutDataSet("ds_default", ds);
        System.out.println("xlsx  食奄 猿走尽嬢推~~~~~~~~~");
        p_tr.setOutDataSet("dsRESULT", CommUtil.getResultDataSet("RESULT_MSG", resultMsg));
        System.out.println("xlsx  食奄猿走???");

    }


	/**
	 * 舛左研 煽舌馬澗 WORK五社球.
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
			resultMsg = "穿端 "+voList.size()+"闇 掻 "+err_cnt+"闇税 去系戚 叔鳶馬心柔艦陥.";
		}else{
			resultMsg = "穿端 "+voList.size()+"闇税 去系戚 失因馬心柔艦陥.";
		}

        p_tr.setOutDataSet("dsRESULT", CommUtil.getResultDataSet("RESULT_MSG", resultMsg));
	}


	public void Bud025ExcelCMD_SAV(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** 闘沓詮芝聖 呪楳馬奄 是背辞 getConnection(false)稽 竺舛馬心陥 **/
		Bud025ExcelDAO dao = new Bud025ExcelDAO("default", p_tr);

		dao.Bud025ExcelCMD_SAV(vo, p_box);

	}		
	
	
	
	/**
	 * 舛左研 呪舛 馬澗 WORK五社球.
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
			resultMsg = "穿端 "+voList.size()+"闇 掻 "+err_cnt+"闇税 去系戚 叔鳶馬心柔艦陥.";
		}else{
			resultMsg = "穿端 "+voList.size()+"闇税 去系戚 失因馬心柔艦陥.";
		}

        p_tr.setOutDataSet("dsRESULT", CommUtil.getResultDataSet("RESULT_MSG", resultMsg));
	}

	/**
	 * 原姶 馬澗 WORK五社球.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void Bud025ExcelCMD_SAV_END(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet梓端研 GauceValueObject稽 痕発馬食 坦軒 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("ds_default");

		/** 闘沓詮芝聖 呪楳馬奄 是背辞 getConnection(false)稽 竺舛 **/
		Bud025ExcelDAO dao = new Bud025ExcelDAO("default", p_tr);

		dao.Bud025ExcelCMD_SAV_END(p_box);

	}



}

