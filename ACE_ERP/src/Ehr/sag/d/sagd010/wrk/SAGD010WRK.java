package Ehr.sag.d.sagd010.wrk;

import Ehr.sag.d.sagd010.dao.SAGD010DAO;
import Ehr.vlu.k.vluk030.dao.VLUK030DAO;

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
import com.shift.gef.core.exception.DuplicateKeyException;
import com.shift.gef.core.exception.SysException;
import com.shift.gef.core.log.Log;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

import Ehr.common.util.CommUtil;
import Ehr.common.util.FileUtil;
import Ehr.common.util.JSPUtil;
import Ehr.common.util.POIUtil;

public class SAGD010WRK {

	/**
	 * �޿����̺� ��ȸ [FirstRow ���]
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SAGD010_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class ��ü ������ ���� �޼ҵ� ȣ�� * */
		SAGD010DAO dao = new SAGD010DAO("default", p_tr);
		dao.SAGD010_SHR(p_box);

	}

	/**
	 * �޿����̺� �������� ��ȸ [FirstRow ���]
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SAGD010_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class ��ü ������ ���� �޼ҵ� ȣ�� * */
		SAGD010DAO dao = new SAGD010DAO("default", p_tr);
		dao.SAGD010_SHR_01(p_box);

	}

	/**
	 * ����File ���� ��ȸ
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void SAGD010_SHR_02( CBox p_box, TrBox p_tr ) throws CException {

		InputStream is = FileUtil.getFileStream(p_tr, "dsFILE_UPLOAD", "FILE_URL")[0];

		//�������� ������ ��� ���� �����ͼ�
		GauceDataSet ds = new GauceDataSet();
        GauceDataRow dr = null;

		ds.addDataColumn(new GauceDataColumn("ENO_NO", GauceDataColumn.TB_STRING ));
		ds.addDataColumn(new GauceDataColumn("JOB_CD", GauceDataColumn.TB_STRING ));
		ds.addDataColumn(new GauceDataColumn("STR_YMD", GauceDataColumn.TB_STRING ));
		ds.addDataColumn(new GauceDataColumn("BAS_AMT", GauceDataColumn.TB_NUMBER ));
		ds.addDataColumn(new GauceDataColumn("DUTY_AMT", GauceDataColumn.TB_NUMBER ));
		ds.addDataColumn(new GauceDataColumn("LAW_AMT", GauceDataColumn.TB_NUMBER ));
		ds.addDataColumn(new GauceDataColumn("BNS_AMT", GauceDataColumn.TB_NUMBER ));

		try{

			POIFSFileSystem fs = new POIFSFileSystem(is);

			//��ũ���� ����!
            HSSFWorkbook workbook = new HSSFWorkbook(fs);

            //��Ʈ �̸��� ��Ʈ��ȣ�� ����
        	HSSFSheet sheet = workbook.getSheetAt(0);//ù��° ��Ʈ
            HSSFRow row = null;

            //HEADER �κ� �ǳʶ� INDEX 1���� ����
            for (int i = 1; i < sheet.getPhysicalNumberOfRows(); i++) {
            	// ��Ʈ�� ���� ���� �ϳ��� ����
                row = sheet.getRow(i);

                if(row.getPhysicalNumberOfCells() != 7)
                    throw new BizException("���������� ���� ������ 7���̾�� �մϴ�!");

                dr = ds.newDataRow();

                //������� ���ڷ� �ν��Ͽ� ��½� ������ �־� �������� ����
                dr.setString(0, POIUtil.getString(row, 0));
                dr.setString(1, POIUtil.getString(row, 1));
                dr.setString(2, POIUtil.getString(row, 2));
                dr.setLong(  3, POIUtil.getLong(  row, 3));
                dr.setLong(  4, POIUtil.getLong(  row, 4));
                dr.setLong(  5, POIUtil.getLong(  row, 5));
                dr.setLong(  6, POIUtil.getLong(  row, 6));


                ds.addDataRow(dr);
           	}

		}catch(Exception e) {
			Log.err.println(e.getMessage());
		}

		p_tr.setOutDataSet("dsT_CP_PAYTABLE", ds);
	}

	/**
	 * �޿����̺� ����, ����
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void SAGD010_SAV( CBox p_box, TrBox p_tr ) throws CException {
		SAGD010DAO dao = new SAGD010DAO("default", p_tr);

        GauceValueObject voList = p_tr.getInGauceValueObject("SAV");
        GauceValueObject vo = null;

        String resultMsg = "";

        if(JSPUtil.rns(p_box.get("TYPE")).equals("UPLOAD"))
            dao.SAGD010_DEL_01(p_box);

        for (int i=0; i<voList.size(); i++) {
            vo = voList.get(i); // LIST -> ROW

            
          
            
            try {
                if(vo.getInt("TX_MODE") == 2) {
                	//dao.SAGD010_UPT2(p_box, vo);	//����� �������� ����
                    dao.SAGD010_INS(p_box, vo);		//�޿����̺� �ű� ����

                } else if(vo.getInt("TX_MODE") == 3) {
            		//System.out.print(">>>>>>>>>>>>>>>>>>  VO = " +vo);	
                	this.SAGD010_UPT(vo, p_box, p_tr);
                    //dao.SAGD010_UPT(p_box, vo);		//�޿����̺� ����
                }

            } catch (SysException e) {
                resultMsg += (i+1)+"��°�� [OCC_CD:"+vo.getString("OCC_CD")+", JOB_CD:"+vo.getString("JOB_CD")+", HOB_CD:"+vo.getString("HOB_CD")+", APY_YMD:"+vo.getString("APY_YMD")+"] �� ����Ÿ ��Ͽ� �����Ͽ����ϴ�.\n";
            } catch (DuplicateKeyException e) {
                resultMsg += (i+1)+"��°�� [OCC_CD:"+vo.getString("OCC_CD")+", JOB_CD:"+vo.getString("JOB_CD")+", HOB_CD:"+vo.getString("HOB_CD")+", APY_YMD:"+vo.getString("APY_YMD")+"] �� ����Ÿ�� �̹� ��ϵǾ� �ֽ��ϴ�.\n";
            } catch (Exception e) {
                resultMsg += e.getMessage();
            }
        }
        p_tr.setOutDataSet("dsRESULT", CommUtil.getResultDataSet("RESULT_MSG", resultMsg));
	}

	public void SAGD010_UPT(GauceValueObject vo, CBox p_box, TrBox p_tr ) throws CException {	
		
        //�ʿ��� ���� ����
		SAGD010DAO dao = new SAGD010DAO("default", p_tr);
	
        dao.SAGD010_UPT(p_box, vo);		//�޿����̺� ����	
		
	}	
	

	/**
	 * �޿����̺� ����
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void SAGD010_DEL( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");


		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		SAGD010DAO dao = new SAGD010DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList���� ValueObject�� ������ �κ� **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

			/**
			 * Ʈ������ ��忡 ���� ó�� �ϰ� �Ǹ�, TX_MODE���� �Ʒ��� ����.
			 *  - 1 : NORMAL
			 *  - 2 : INSERT
			 *  - 3 : UPDATE
			 *  - 4 : DELETE
			 */
			switch (vo.getInt("TX_MODE")) {
			case 2:
				// insert;
				break;
			case 3:
				// update;
				break;
			case 4:
				// delete;
				dao.SAGD010_DEL(p_box, vo);
				dao.SAGD010_UPT3(p_box, vo);
				break;
			}
		}

	}

}
