<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String tmpPage = request.getParameter("cpage");
int lastPage = 0; 
String args="";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="inc_html_header.jsp" %>
<%
//페이지 번호 설정(페이지 번호는 게시판 전체에서 필수요소로 사용됨)
int cpage = 1, psize = 5, bsize = 10, sidx = 0;
//cpage : 현재 페이지번호, psize : 페이지크기, bsize : 블록크기, sidx : limit의 시작인덱스
if (tmpPage == null || tmpPage.equals("")) {
//현재 페이지번호가 없을 경우 무조건 1페이지로 셋팅
	cpage = 1;
} else {
//현재 페이지번호가 있을 경우 정수로 형변환함(여러 계산에서 사용되기도 하며, 인젝션 공격을 막기 위한 조치)
	cpage = Integer.valueOf(tmpPage);
}
sidx = (cpage - 1) * psize;	// limit의 시작인덱스

%>
<div class="contents_area">
	<div id = "searchbox_faq" >
		<div id="notice_title" align="center">
			<ul>
				<li>
					<a href="board_notice.jsp">NOTICE</a>&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="board_qna.jsp">QNA</a>&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="board_faq.jsp">FAQ</a>&nbsp;&nbsp;&nbsp;&nbsp;
				</li>
			</ul>
		</div>
		<div id="tbl_sb_free">
		<table width="1098">
			<tr>
				<th width="10%">번호</th>
				<th width="*">제목</th>
			</tr>
				<%
					int num = 15; // FAQ 의 개수 (FAQ 개수가 늘어나면 이 부분을 수정 하면 됩니다.)
					String title, date, linkHead = "", linkTail = "";
						// 검색된 게시물이 있으면
						lastPage = (num - 1) / psize + 1;	// 마지막 페이지 번호
						num = num - (cpage - 1) * psize;	// 게시물 개수 번호
					
					if(cpage == 1)
					{
				%>
			<tr>
				<td width="10%">15</td>
				<td width="*">Q. 주문 후 색상 및 사이즈 등을 바꿀 수 있나요?</td>
			</tr>
			<tr>
				<td></td>
				<td>A. 상품이 발송전이라면 당연히 바꿔서 배송해드릴 수 있습니다. 1:1게시판에 남겨주시면 원하는 색상과 사이즈 디자인를 남겨주시면 저희 고객지원센터에서 신속히 변경해드리고 있습니다.</td>
			</tr>
			<tr>
				<td width="10%">14</td>
				<td width="*">Q. 회원가입하면 혜택이 있나요?</td>
			</tr>
			<tr>
				<td></td>
				<td>A. 소녀시대 가족이 되신다면 상품 구매시 포인트 적립이 되어 다음 상품 구매시 포인트를 사용하여 사용하신 포인트만큼 할인혜택을 받으실 수 있습니다.</td>
			</tr>
			<tr>
				<td width="10%">13</td>
				<td width="*">Q. 동일상품을 여러색상을 구매하려는데 어떻게 해야 할까요?</td>
			</tr>
			<tr>
				<td></td>
				<td>A. 중복 옵션 선택이 가능하기 때문에 구매 원하는 색상과 사이즈 옵션을 각각 선택하여 구매해주시면 됩니다. 옵션창 밑으로 선택한 옵션이 적용되어 나오기 때문에 잘 확인하여 선택해주세요.</td>
			</tr>
			<tr>
				<td width="10%">12</td>
				<td width="*">Q. 적립금이 있는데 현금 환불 받을수 있나요?</td>
			</tr>
			<tr>
				<td></td>
				<td>A. 적립금은 현불로 환불이 불가능합니다. 회원 탈퇴시에는 자동으로 소멸됩니다.</td>
			</tr>
			<tr>
				<td width="10%">11</td>
				<td width="*">Q. 아이디와 패스워드를 잊어버렸어요!</td>
			</tr>
			<tr>
				<td></td>
				<td>A. 아이디를 잊어버렸을경우 로그인-회원아이디 찾기-이름, 이메일 입력-아이디 바로 확인됩니다.<br>비밀번호를 잊어버렸을경우 로그인-비밀번호 찾기-이름,아이디,이메일 입력-기재하신 메일주소로 임시 비밀번호가 발송됩니다.<br>
					이메일로도 비밀번호 확인이 안되실경우, 스팸메일로 확인될수도 있으니 참고바랍니다. 아이디는 가입 하셨던분의 성함과 이메일 주소로 확인이 가능 합니다.<br>
					위와 같이 하셨는데도 확인이 어려울실경우, 고객센터로 전화를 주시면 확인하여 도움 드리겠습니다.
				</td>
			</tr>
			<%
			} else if(cpage == 2) {			
			%>
			<tr>
				<td width="10%">10</td>
				<td width="*">Q. 회원 탈퇴는 어떻게 하나요?</td>
			</tr>
			<tr>
				<td></td>
				<td>A. 회원탈퇴는 로그인 후 마이페이지에서 가능하십니다. 탈퇴시 현재 보유하고 있는 적립금 및 예치금은 모두 소멸되고, 탈퇴 후에는 사용하시던 아이디는 복구 불가능하며 재가입 또한 불가능하니 이 점 참고해주세요.</td>
			</tr>
			<tr>
				<td width="10%">9</td>
				<td width="*">Q. 주소와 전화번호등 개인정보 변경은 어떻게 해요?</td>
			</tr>
			<tr>
				<td></td>
				<td>A. 전화번호 및 주소등 개인정보 변경을 원하실때는 상단에 마이페이지-회원정보수정에서 변경해주시면 됩니다.</td>
			</tr>
			<tr>
				<td width="10%">8</td>
				<td width="*">Q. 반품이 불가능한 경우는요?</td>
			</tr>
			<tr>
				<td></td>
				<td>A. [전자상거래 소비자보호에 관한 법률]에 의거하여 아래와같은 사유로 반품처리는 불가합니다.<br><br>
				- 제품을 훼손한 경우 (제품을 확인하기 위해 포장 훼손한 경우는 제외)<br>- 사용 및 시간의 경과로 상품의 가치가 현저히 감소한 경우<br>
				- 복제가 가능한 제품의 포장을 훼손한 경우<br>- 상품 불량/오배송으로 인한 교환/반품의 경우 동일상품으로 무상교환 해드리며, 전액 환불이 가능합니다.</td>
			</tr>
			<tr>
				<td width="10%">7</td>
				<td width="*">Q. 교환상품 받는데 얼마나 걸릴까요?</td>
			</tr>
			<tr>
				<td></td>
				<td>A. 상품 보내주신 날짜로부터 1~2일 후에 회수되어 교환접수 되며 교환 상품의 입고 준비기간 또한 일반 배송일과 동일하게 약 2~3일정도 소요되어, 총 4~7일 후에 수령이 가능하십니다. 최대한 빠른 교환 처리해드리겠습니다.</td>
			</tr>
			<tr>
				<td width="10%">6</td>
				<td width="*">Q. 적립금이 있는데 현금 환불 받을수 있나요??</td>
			</tr>
			<tr>
				<td></td>
				<td>A. 적립금은 현불로 환불이 불가능합니다. 회원 탈퇴시에는 자동으로 소멸됩니다
				</td>
			</tr>
			<%
			} else if(cpage == 3) {
			%>
			<tr>
				<td width="10%">5</td>
				<td width="*">Q. 카드취소 요청했는데, 취소처리가 잘 됐나요?</td>
			</tr>
			<tr>
				<td></td>
				<td>A. 카드취소처리는 접수 후 약 7~10일 후에 카드사에서 취소확인이 가능하십니다. 고객님의 소중한 개인정보 유출피해를 방지하기 위하여 부득이 최종승인취소를 확인할 수 없답니다. 번거롭더라도 카드사로부터 확인 부탁드립니다.</td>
			</tr>
			<tr>
				<td width="10%">4</td>
				<td width="*">Q. 비회원도 구매할 수 있나요?</td>
			</tr>
			<tr>
				<td></td>
				<td>A. 사뿐은 회원이 아니셔도 주문 가능하십니다. 상품을 CART(장바구니)에 담아 구매하시면 됩니다. 다만 할인이나 적립금 게시판 사용에 제한을 받으실 수 있습니다.</td>
			</tr>
			<tr>
				<td width="10%">3</td>
				<td width="*">Q. 정사이즈 맞나요?</td>
			</tr>
			<tr>
				<td></td>
				<td>A. 사이즈의 경우 상품 상세 페이지 초반 부분과 하단 제품설명 두 곳에  Size Tip이 기재되어 있습니다~<br><br>※ 주의사항<br>
				1. Size Tip은 저희 직원들이 직접 착용후 남긴 추천사이즈입니다.<br>
				2. 발볼, 발등 높이에 따른 개인차가 있을 수 있으니 상세설명 TIP을 참고해주세요.<br>
				3. 힐, 펌프스->실리콘 패드/슬립온, 스니커즈, 로퍼->깔창으로 사이즈 보완하시면 교환반품없이 편하게 착용하실 수 있으세요~</td>
			</tr>
			<tr>
				<td width="10%">2</td>
				<td width="*">Q. 굽 조절, 발볼 조절 가능하나요?</td>
			</tr>
			<tr>
				<td></td>
				<td>A. 신발의 굽 조절 또는 발볼 조절의 개별맞춤은 어렵습니다. 소녀시대에는 다양한 굽높이의 힐과 상품들이 있으며 상품마다 사이즈가 상세하게 기재되어 있으니 고객님 마음에 드시는 상품으로 선택해주세요.<br><br>
				※ 간단하게 발볼 늘리는 방법<br>
				1. 두꺼운 양말 착용 후 신발을 신어주시고 발볼쪽에 드라이기로 열을 가하시면 발볼 조절이 가능합니다.<br>
				2. 제품에 오랫동안 뜨거운 열기를 가하면 소재에 따라 손상이 갈 수 있으니 주의 부탁드릴게요.</td>
			</tr>
			<tr>
				<td width="10%">1</td>
				<td width="*">Q. 언제 배송되나요?</td>
			</tr>
			<tr>
				<td></td>
				<td>배송은 입금이 확인되고 3~7일 안에 됩니다! CJ대한통운으로 발송하고, 송장번호를 카카오톡(실패시 문자전송)으로 보내드려요! 주말을 제외하고 1~2일 내로 받아보실 수 있어요!
				<br><br>고객님! 이럴 땐 시간이 조금 더 걸릴 수 있어요!<br>
				1. 주문이 폭주하고, 발송이 지연되는 상품일 경우<br>
				2. 명절이나 연말처럼 택배사에 배송물량이 밀려있는 경우<br>
				3. 폭우, 폭설, 태풍 등 심한 날씨 영향을 받는 경우(특히 도서산간 배송 시에 배가 뜨지 않는 경우)</td>
			</tr>
			<%
			}
			%>
		</table>
		</div>
		<div id="paging" align="center">
			<a href="board_faq.jsp?cpage=1<%=args %>">&lt;&lt;</a><!-- 첫번째페이지로 이동 -->
			<%
				
				linkHead = "";
				linkTail = "";
				if (cpage > 1) {
				// 현재 페이지번호가 1보다 크면(현재 페이지의 이전 페이지가 존재하면)
					linkHead = "<a href='board_faq.jsp?cpage=" + (cpage - 1) + args + "'>";
					linkTail = "</a>";
				}
				out.println(linkHead + "&lt;" + linkTail);
				// 이전페이지로 이동
		
				int spage = (cpage - 1) / bsize * bsize + 1;
				// 각 블록의 시작 페이지 번호
				for (int i = spage ; i < spage + bsize && i <= lastPage ; i++) {
				// 시작 페이지 번호 부터 블록의 크기만큼 또는 마지막 페이지까지 루프를 돔
					if (i == cpage) {
					// 현재 페이지번호이면(링크를 생략하고, 굵게 표현)
						out.println("&nbsp;<b>" + i + "</b>&nbsp;");
					} else {
						out.println("&nbsp;<a href='board_faq.jsp?cpage=" + i + args + "'>" + i + "</a>&nbsp;");
					}
				}
				linkHead = "";
				linkTail = "";
				// 기존의 값이 남아 있지 않게 다시 빈 문자열로 초기화
				if (cpage < lastPage) {
					// 현재 페이지 번호가 마지막 페이지 번호보다 작으면(현재 페이지의 다음 페이지가 존재하면)
					linkHead = "<a href='board_faq.jsp?cpage=" + (cpage + 1) + args + "'>";
					linkTail = "</a>";
				}
				out.println(linkHead + "&gt;" + linkTail);
				// 다음페이지로 이동
			%>
			
		<a href="board_faq.jsp?cpage=<%=lastPage + args %>">&gt;&gt;</a><!-- 마지막페이지로 이동 -->
		</div>
	</div>
</div>
<%@ include file="inc_html_footer.jsp" %>
</body>
</html>