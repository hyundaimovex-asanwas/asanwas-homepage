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
	 * 급여테이블 조회 [FirstRow 방식]
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SAGD010_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class 객체 생성후 관련 메소드 호출 * */
		SAGD010DAO dao = new SAGD010DAO("default", p_tr);
		dao.SAGD010_SHR(p_box);

	}

	/**
	 * 급여테이블 적용일자 조회 [FirstRow 방식]
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SAGD010_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class 객체 생성후 관련 메소드 호출 * */
		SAGD010DAO dao = new SAGD010DAO("default", p_tr);
		dao.SAGD010_SHR_01(p_box);

	}

	/**
	 * 엑셀File 내용 조회
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void SAGD010_SHR_02( CBox p_box, TrBox p_tr ) throws CException {

		InputStream is = FileUtil.getFileStream(p_tr, "dsFILE_UPLOAD", "FILE_URL")[0];

		//엑셀파일 정보를 담기 위한 데이터셋
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

			//워크북을 생성!
            HSSFWorkbook workbook = new HSSFWorkbook(fs);

            //시트 이름과 시트번호를 추출
        	HSSFSheet sheet = workbook.getSheetAt(0);//첫번째 시트
            HSSFRow row = null;

            //HEADER 부분 건너뜀 INDEX 1부터 시작
            for (int i = 1; i < sheet.getPhysicalNumberOfRows(); i++) {
            	// 시트에 대한 행을 하나씩 추출
                row = sheet.getRow(i);

                if(row.getPhysicalNumberOfCells() != 7)
                    throw new BizException("엑셀파일의 셀의 갯수는 7개이어야 합니다!");

                dr = ds.newDataRow();

                //사번등을 숫자로 인식하여 출력시 문제가 있어 수동으로 변경
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
	 * 급여테이블 저장, 수정
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
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
                	//dao.SAGD010_UPT2(p_box, vo);	//저장시 종료일자 수정
                    dao.SAGD010_INS(p_box, vo);		//급여테이블 신규 저장

                } else if(vo.getInt("TX_MODE") == 3) {
            		//System.out.print(">>>>>>>>>>>>>>>>>>  VO = " +vo);	
                	this.SAGD010_UPT(vo, p_box, p_tr);
                    //dao.SAGD010_UPT(p_box, vo);		//급여테이블 수정
                }

            } catch (SysException e) {
                resultMsg += (i+1)+"번째줄 [OCC_CD:"+vo.getString("OCC_CD")+", JOB_CD:"+vo.getString("JOB_CD")+", HOB_CD:"+vo.getString("HOB_CD")+", APY_YMD:"+vo.getString("APY_YMD")+"] 의 데이타 등록에 실패하였습니다.\n";
            } catch (DuplicateKeyException e) {
                resultMsg += (i+1)+"번째줄 [OCC_CD:"+vo.getString("OCC_CD")+", JOB_CD:"+vo.getString("JOB_CD")+", HOB_CD:"+vo.getString("HOB_CD")+", APY_YMD:"+vo.getString("APY_YMD")+"] 의 데이타가 이미 등록되어 있습니다.\n";
            } catch (Exception e) {
                resultMsg += e.getMessage();
            }
        }
        p_tr.setOutDataSet("dsRESULT", CommUtil.getResultDataSet("RESULT_MSG", resultMsg));
	}

	public void SAGD010_UPT(GauceValueObject vo, CBox p_box, TrBox p_tr ) throws CException {	
		
        //필요한 변수 선언
		SAGD010DAO dao = new SAGD010DAO("default", p_tr);
	
        dao.SAGD010_UPT(p_box, vo);		//급여테이블 수정	
		
	}	
	

	/**
	 * 급여테이블 삭제
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void SAGD010_DEL( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");


		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		SAGD010DAO dao = new SAGD010DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

			/**
			 * 트랜젝션 모드에 따라 처리 하게 되며, TX_MODE값은 아래와 값다.
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
