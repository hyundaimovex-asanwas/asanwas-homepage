package Ehr.wel.n.weln030.wrk;

import Ehr.wel.n.weln030.dao.WELN030DAO;

import java.io.InputStream;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
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

public class WELN030WRK {

	/**
	 * ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void WELN030_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** WELJ030DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		WELN030DAO dao = new WELN030DAO("default", p_tr);
		dao.WELN030_SHR(p_box);

	}


	/**
	 * ������ �����ϱ� ���� WORK�޼ҵ� ȣ��
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void WELN030_DEL(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_WL_WELCARD");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		WELN030DAO dao = new WELN030DAO("default", p_tr);
		WELN030DAO dao2 = new WELN030DAO("default", p_tr);
		
		dao.WELN030_DEL(p_box);
		dao2.WELN030_DEL2(p_box);


	}


    /**
     * EXCEL ���� ���ε�
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void WELN030_ULD( CBox p_box, TrBox p_tr ) throws CException {

        InputStream is = FileUtil.getFileStream(p_tr, "dsFILE_UPLOAD", "FILE_URL")[0];

        String resultMsg = "";

        //�������� ������ ��� ���� �����ͼ�
        GauceDataSet ds = new GauceDataSet();
        GauceDataRow dr = null;

        ds.addDataColumn(new GauceDataColumn("SEQID",  GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("ENO_NM",  GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("RESINO",  GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("APPDT", GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("MEMBER",  GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("SALAMT", GauceDataColumn.TB_STRING ));

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

                if(row.getPhysicalNumberOfCells() != 6)
                    throw new BizException("���������� ���� ������ 6���̾�� �մϴ�!");
                try {
                    dr = new GauceDataRow(ds.getDataColCnt());

                    dr.setString( 0, POIUtil.getString(row, 0));
                    dr.setString( 1, POIUtil.getString(row, 1));
                    dr.setString( 2, POIUtil.getString(row, 2));
                    dr.setString( 3, POIUtil.getString(row, 3));
                    dr.setString( 4, POIUtil.getString(row, 4));
                    dr.setString( 5, POIUtil.getString(row, 5));

                    ds.addDataRow(dr);

                } catch (Exception e) {
                    resultMsg += e.getMessage();
                }
            }
        }

        p_tr.setOutDataSet("dsT_WL_WELCARD", ds);
        p_tr.setOutDataSet("dsRESULT", CommUtil.getResultDataSet("RESULT_MSG", resultMsg));

    }


	/**
	 * ������ �����ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void WELN030_SAV(CBox p_box, TrBox p_tr) throws CException {

        String resultMsg = "";
        int err_cnt = 0;

		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_WL_WELCARD");
        GauceValueObject vo = null;

		WELN030DAO dao = new WELN030DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {
			vo = voList.get(i);

            try {
                this.WELN030_SAV(vo, p_box, p_tr);
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


	public void WELN030_SAV(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		WELN030DAO dao = new WELN030DAO("default", p_tr);

		dao.WELN030_SAV(vo, p_box);

	}		
	
	
	
	/**
	 * ������ ���� �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void WELN030_SAV_01(CBox p_box, TrBox p_tr) throws CException {

        String resultMsg = "";
        int err_cnt = 0;

		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_WL_WELCARD");
        GauceValueObject vo = null;

		WELN030DAO dao = new WELN030DAO("default", p_tr);

        dao.WELN030_SAV_01(vo, p_box);

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
	public void WELN030_SAV_END(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_WL_WELCARD");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		WELN030DAO dao = new WELN030DAO("default", p_tr);

		dao.WELN030_SAV_END(p_box);

	}



}

