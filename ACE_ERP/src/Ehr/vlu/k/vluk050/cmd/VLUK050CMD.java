package Ehr.vlu.k.vluk050.cmd;

import Ehr.vlu.k.vluk050.wrk.VLUK050WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.proxy.EjbProxy;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class VLUK050CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		VLUK050WRK wrk = new VLUK050WRK();

		// S_MODE가 조회인 경우
		if (p_box.get("S_MODE").equals("SHR")) {
			wrk.VLUK050_SHR(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR2")) {
            wrk.VLUK050_SHR2(p_box, p_tr);			
		}else  if (p_box.get("S_MODE").equals("SHR_01")) {
            wrk.VLUK050_SHR_01(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_02")) {
            wrk.VLUK050_SHR_02(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_03")) {
            wrk.VLUK050_SHR_03(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_SCR")) {
            wrk.VLUK050_SHR_SCR(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_SCR_01")) {
            wrk.VLUK050_SHR_SCR_01(p_box, p_tr);     
		}else  if (p_box.get("S_MODE").equals("SHR_ITEM")) {
            wrk.VLUK050_SHR_ITEM(p_box, p_tr);     
		}else  if (p_box.get("S_MODE").equals("SHR_ITEM_01")) {
            wrk.VLUK050_SHR_ITEM_01(p_box, p_tr);      
		}else  if (p_box.get("S_MODE").equals("SHR_CMT")) {
            wrk.VLUK050_SHR_CMT(p_box, p_tr);               
		}else  if (p_box.get("S_MODE").equals("SAV")) {	
            wrk.VLUK050_SAV(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SAV_01")) {
            wrk.VLUK050_SAV_01(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SAV_CMT")) {
            wrk.VLUK050_SAV_CMT(p_box, p_tr);            
		}else  if (p_box.get("S_MODE").equals("SAV_COR")) {
            wrk.VLUK050_SAV_COR(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SAV_COR_01")) {
            wrk.VLUK050_SAV_COR_01(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SAV_COR_02")) {
            wrk.VLUK050_SAV_COR_02(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SAV_COR_03")) {
            wrk.VLUK050_SAV_COR_03(p_box, p_tr);
		}		
		
		//EjbProxy.controlTxn(new VLUK050EJB(p_box, p_tr));
	}


}