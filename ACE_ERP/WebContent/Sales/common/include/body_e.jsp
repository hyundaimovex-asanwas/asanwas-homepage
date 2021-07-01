<%@ page language="java" contentType="text/html;charset=euc-kr" %>
							</td>
						</tr>
						
					</table>
				</td>
			</tr>
<!-- ???? ???? BODY END -->			
		</table>
	<%
/*=============================================================================
			Status Bar Falsh
=============================================================================*/
%>	
<%
	String dirPath = request.getContextPath();
%>
	<iframe id="LowerFrame" 
			name="work" 
			style="visibility:hidden; position:absolute; left:280px; top:220px;" 
			Frameborder="0" src="<%=dirPath%>/Sales/common/img/flash/loading.swf" 
			width="320px" 
			height="42px">
	</iframe>	
<!---------------------------------- BODY End -------------------------------->	
	</body>
</html>