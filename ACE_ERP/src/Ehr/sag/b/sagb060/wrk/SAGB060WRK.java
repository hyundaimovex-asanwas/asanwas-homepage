package Ehr.sag.b.sagb060.wrk;

import Ehr.sag.b.sagb060.dao.SAGB060DAO;

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
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

import Ehr.but.a.buta020.dao.BUTA020DAO;
import Ehr.common.util.CommUtil;
import Ehr.common.util.FileUtil;
import Ehr.common.util.POIUtil;

public class SAGB060WRK {

	/**
	 * �������Ұ���File ���� ��ȸ
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void SAGB060_SHR( CBox p_box, TrBox p_tr ) throws CException {

		InputStream is = FileUtil.getFileStream(p_tr, "dsFILE_UPLOAD", "FILE_URL")[0];

        /** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
        SAGB060DAO dao = new SAGB060DAO("default", p_tr);
        
        GauceValueObject voList = null;
        
        GauceValueObject vo = null;

        String resultMsg = "";


		//�������� ������ ��� ���� �����ͼ�
		GauceDataSet ds = new GauceDataSet();
        GauceDataRow dr = null;
		ds.addDataColumn(new GauceDataColumn("ENO_NO", GauceDataColumn.TB_STRING,  8, 0, GauceDataColumn.TB_KEY));
        ds.addDataColumn(new GauceDataColumn("AMOUNT", GauceDataColumn.TB_NUMBER ));
        ds.addDataColumn(new GauceDataColumn("REMARK", GauceDataColumn.TB_STRING ));
		ds.addDataColumn(new GauceDataColumn("OCC_CD", GauceDataColumn.TB_STRING ));
		ds.addDataColumn(new GauceDataColumn("DPT_CD", GauceDataColumn.TB_STRING ));
		ds.addDataColumn(new GauceDataColumn("JOB_CD", GauceDataColumn.TB_STRING ));
		ds.addDataColumn(new GauceDataColumn("PIS_YY", GauceDataColumn.TB_STRING ));
		ds.addDataColumn(new GauceDataColumn("PIS_MM", GauceDataColumn.TB_STRING ));
		ds.addDataColumn(new GauceDataColumn("SAL_GBN", GauceDataColumn.TB_STRING ));
		ds.addDataColumn(new GauceDataColumn("SAL_CD", GauceDataColumn.TB_STRING ));
		ds.addDataColumn(new GauceDataColumn("AD_TAG", GauceDataColumn.TB_STRING ));
        ds.addDataColumn(new GauceDataColumn("BON_NUM", GauceDataColumn.TB_STRING ));

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

            	if(row.getPhysicalNumberOfCells() != 5)
                    throw new BizException("���������� ���� ������ 5���̾�� �մϴ�!");

                try {
            		dr = new GauceDataRow(ds.getDataColCnt());

                    //������� ��ȸ
                    voList = GauceUtils.getGauceValueObject(this.SAGB060_SHR(POIUtil.getString(row, 0),p_tr));

                    if(voList.size() != 1)
                        throw new Exception((i+1)+"��°�� ("+POIUtil.getString(row, 0)+") �� ����� �������� �ʽ��ϴ�.\n");

                    vo = voList.get(0);

            		dr.setString( 0, POIUtil.getString(row, 0));
                    dr.setLong(   1, POIUtil.getLong(  row, 1));
                    dr.setString( 2, POIUtil.getString(row, 4));
            		dr.setString( 3, vo.getString("OCC_CD"));
            		dr.setString( 4, vo.getString("DPT_CD"));
            		dr.setString( 5, vo.getString("JOB_CD"));
                    dr.setString( 6, "");
                    dr.setString( 7, "");
                    dr.setString( 8, "");
                    dr.setString( 9,  POIUtil.getString(row, 2));
                    dr.setString(10, POIUtil.getString(row, 3));
                    dr.setString(11, "");


                    ds.addDataRow(dr);
                } catch (Exception e) {
                    resultMsg += e.getMessage();
                }
            }
        }

		p_tr.setOutDataSet("dsT_CP_CHANGE", ds);
        p_tr.setOutDataSet("dsRESULT", CommUtil.getResultDataSet("RESULT_MSG", resultMsg));
	}

	
	public GauceDataSet SAGB060_SHR(String Eno_no, TrBox p_tr) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		SAGB060DAO dao = new SAGB060DAO("default", p_tr);

		return dao.SAGB060_SHR(Eno_no);

	}		
	
	
	
	/**
	 * �������Ұ���File���� ����
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void SAGB060_SAV( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_CP_CHANGE");
        GauceValueObject vo = null;
        GauceValueObject chk_worklog = null;
        GauceValueObject voT_CP_CHANGE = null;//�۾���ȣ ��ȸ��

        int a_pro_sts = 0;

        String WRK_SEQ = "";
        String end_enono = "";
        String resultMsg = "";

		SAGB060DAO dao = new SAGB060DAO("default", p_tr);

		//ù�����϶� work log���� �޻� ó���� �������� ���θ� ������ �´�.
        chk_worklog = GauceUtils.getGauceValueObject(this.SAGB060_CHK_WORKLOG(p_box, p_tr)).get(0);
        
        a_pro_sts = chk_worklog.getInt("A_PRO_STS");

        //System.out.println("a_pro_sts : " +a_pro_sts);

        //�۾���ȣ�߰� - ����� �۾���ȣ���ο�
        voT_CP_CHANGE = GauceUtils.getGauceValueObject(this.SAGB060_SHR_01(p_box, p_tr)).get(0);
        
        WRK_SEQ = voT_CP_CHANGE.get("WRK_SEQ");

        
        // 2012.12.21 �̵��� ���� �̰Ͷ��� ���� �������ҵ��� �� ���󰬴�.
        
        //dao.SAGB060_DEL(p_box);

		for (int i=0; i<voList.size(); i++) {
			
			vo = voList.get(i);	// LIST -> ROW
			
			//System.out.print(vo);
            // �ش� work log�� ����Ǿ��ų� work log�� ������ ���θ� ����
			
            if( (vo.getString("OCC_CD").equals("A") && (a_pro_sts == 0 || a_pro_sts == 6)) ) {
            	
                end_enono += vo.get("ENO_NO")+"\n";
                
                resultMsg += (i+1)+"��°�� ("+vo.getString("ENO_NO")+") �� �۾��αװ� ����Ǿ����ϴ�.\n";
                
                continue;
            }

            //����Ÿ�Է��� ������ ����Ÿ ����
            try {
                this.SAGB060_INS(p_box, vo, p_tr, WRK_SEQ);
                
            } catch(CException e) {
            	
                resultMsg += (i+1)+"��°�� ("+vo.getString("ENO_NO")+") �� ����Ÿ ��Ͽ� �����Ͽ����ϴ�.\n";
                
            }
            
		}

        p_tr.setOutDataSet("dsRESULT", CommUtil.getResultDataSet("RESULT_MSG", resultMsg));
        
	}
	
	
	public void SAGB060_INS(CBox p_box, GauceValueObject vo, TrBox p_tr, String WRK_SEQ) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		SAGB060DAO dao = new SAGB060DAO("default", p_tr);

		dao.SAGB060_INS(p_box, vo, WRK_SEQ);

	}		
	
	
	public GauceDataSet SAGB060_CHK_WORKLOG(CBox p_box, TrBox p_tr) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		SAGB060DAO dao = new SAGB060DAO("default", p_tr);

		return dao.SAGB060_CHK_WORKLOG(p_box);

	}			
	
	
	public GauceDataSet SAGB060_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		SAGB060DAO dao = new SAGB060DAO("default", p_tr);

		return dao.SAGB060_SHR_01(p_box);

	}			
	
	
}




