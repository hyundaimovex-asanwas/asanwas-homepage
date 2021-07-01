package Ehr.eis.t.eist050.wrk;

import java.io.InputStream;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;

import Ehr.common.util.CommUtil;
import Ehr.common.util.FileUtil;
import Ehr.common.util.POIUtil;
import Ehr.eis.t.eist010.dao.EIST010DAO;
import Ehr.eis.t.eist050.dao.EIST050DAO;
import Ehr.sag.d.sagd030.dao.SAGD030DAO;
import Ehr.wel.n.weln030.dao.WELN030DAO;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.BizException;
import com.shift.gef.core.exception.CException;
import com.shift.gef.core.log.Log;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class EIST050WRK {
	
	/**
	 * ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void EIST050_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** EIST050DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		EIST050DAO dao = new EIST050DAO("default", p_tr);

        /** SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.EIST050_SHR(p_box);

	}
	
	/**
	 * ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void EIST050_SHR_TEAM(CBox p_box, TrBox p_tr) throws CException {

		/** EIST050DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		EIST050DAO dao = new EIST050DAO("default", p_tr);

        /** SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.EIST050_SHR_TEAM(p_box);

	}
	
	
	
	
	/**
	 * ������ �����ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void EIST050_SAV(CBox p_box, TrBox p_tr) throws CException {

        String resultMsg = "";
        int err_cnt = 0;

		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_TS_LABORCOST");
        GauceValueObject vo = null;

        EIST050DAO dao = new EIST050DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {
			vo = voList.get(i);

            try {
                this.EIST050_SAV(vo, p_box, p_tr);
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
	
	public void EIST050_SAV(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		EIST050DAO dao = new EIST050DAO("default", p_tr);

		dao.EIST050_SAV(vo, p_box);

	}		
		
	
	
	
	/**
	 * �ΰǺ� ��� �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void EIST050_SAV_01(CBox p_box, TrBox p_tr) throws CException {
		


		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		EIST050DAO dao = new EIST050DAO("default", p_tr);
		
		int i=0;

		/** ValueObjectList���� ValueObject�� ������ �κ� **/
		GauceValueObject vo = voList.get(i);	// LIST -> ROW

		//���ν��� �ΰǺ� ���
		dao.EIST050_INS_01(vo, p_box);


		
		
	}

	
	
	
	public void EIST050_INS_01(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		
		EIST050DAO dao = new EIST050DAO("default", p_tr);

		dao.EIST050_INS_01(vo, p_box);

	}		
	
	
	
	
	public void EIST050_UPT(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		
		//System.out.println("vo1========="+vo);
		
		EIST050DAO dao = new EIST050DAO("default", p_tr);

		dao.EIST050_UPT(vo, p_box);

	}			
	
	
	

    /**
     * EXCEL ���� ���ε�
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void EIST050_ULD( CBox p_box, TrBox p_tr ) throws CException {

        InputStream is = FileUtil.getFileStream(p_tr, "dsFILE_UPLOAD", "FILE_URL")[0];

        String resultMsg = "";

        //�������� ������ ��� ���� �����ͼ�
        GauceDataSet ds = new GauceDataSet();
        GauceDataRow dr = null;

        ds.addDataColumn(new GauceDataColumn("ENO_NO",  GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("SAL_AMT",  GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("RET_AMT",  GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("INS_AMT", GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("LUN_AMT",  GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("WEL_AMT", GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("O7_AMT",  GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("BUS_AMT",  GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("PARK_AMT", GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("OIL_AMT",  GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("SUM_AMT", GauceDataColumn.TB_STRING ));
        
        
        

        
        
        
        HSSFWorkbook workbook = null;
        HSSFSheet sheet = null;
        HSSFRow row = null;

        try{
            //��ũ���� ����!
            workbook = new HSSFWorkbook(new POIFSFileSystem(is));
            //��Ʈ �̸��� ��Ʈ��ȣ�� ����
            sheet = workbook.getSheetAt(0);//ù��° ��Ʈ
            row     = null;

        }catch(Exception e) {
            Log.err.println(e.getMessage());
        }

        if(sheet != null) {

            //HEADER �κ� �ǳʶ� INDEX 1���� ����
            for (int i = 1; i < sheet.getPhysicalNumberOfRows(); i++) {

                // ��Ʈ�� ���� ���� �ϳ��� ����
                row = sheet.getRow(i);

                if(row.getPhysicalNumberOfCells() != 10)
                    throw new BizException("���������� ���� ������ 10���̾�� �մϴ�!");
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
                    
                    ds.addDataRow(dr);

                } catch (Exception e) {
                    resultMsg += e.getMessage();
                }
            }
        }

        p_tr.setOutDataSet("dsT_TS_LABORCOST", ds);
        p_tr.setOutDataSet("dsRESULT", CommUtil.getResultDataSet("RESULT_MSG", resultMsg));

    }

	
	
	
	
	
	
	/**
	 * ���� �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void EIST050_DEL(CBox p_box, TrBox p_tr) throws CException {
		
		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_TS_LABORCOST");
			
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		EIST050DAO dao = new EIST050DAO("default", p_tr);

		dao.EIST050_DEL(p_box);

	}
	
	
}

