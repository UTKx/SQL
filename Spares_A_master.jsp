<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="js/miso/miso_js/jquery-2.2.3.min.js"></script>
<script type="text/javascript"
	src="js/assets/js/vendor/jquery-2.1.4.min.js"></script>
<script src="js/JS_CSS/jquery-1.10.2.js" type="text/javascript"></script>
<link rel="stylesheet" href="js/InfiniteScroll/css/datatables.min.css">
<script src="js/InfiniteScroll/js/jquery-1.11.0.js"></script>
<script type="text/javascript"
	src="js/InfiniteScroll/js/datatables.min.js"></script>
<script type="text/javascript"
	src="js/InfiniteScroll/js/jquery.mockjax.min.js"></script>
<script type="text/javascript"
	src="js/InfiniteScroll/js/datatables.mockjax.js"></script>

<script type="text/javascript" src="js/AES_ENC_DEC/lib/aes.js"></script>
<script type="text/javascript" src="js/AES_ENC_DEC/lib/pbkdf2.js"></script>
<script type="text/javascript" src="js/AES_ENC_DEC/AesUtil.js"></script>

<link rel="stylesheet" href="js/assets/scss/style.css">
<link rel="stylesheet" href="js/miso/autoComplate/autoComplate.css">
<script src="js/miso/commonJS/commonmethod.js" type="text/javascript"></script>
<link href="js/Calender/jquery-ui.css" rel="Stylesheet"></link>
<script src="js/Calender/jquery-ui.js" type="text/javascript"></script>


<form:form action="save_Spares_A" method='POST'
	commandName="Stock_masterCmd">
	<div class="animated fadeIn">
		<div class="container" align="center">
			<div class="card">
				<div class="card-header">
					<h5>Cat A Spares Stock</h5>
				</div>
				<div class="card-body card-block">
					<div class="col-md-12">
						<div class="col-md-6">
							<div class="row form-group"></div>
						</div>

					</div>
					<div class="col-md-12">
						<div class="col-md-6">
							<div class="row form-group">
								<div class="col-md-4">
									<label for="text-input" class=" form-control-label"><strong
										style="color: red;">*</strong>Part No</label>
								</div>
								<div class="col-md-8">
									<input type="text" name="part_no" id="part_no"
										class="form-control autocomplete" autocomplete="off">

								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="row form-group">
								<div class="col-md-4">
									<label for="text-input" class=" form-control-label"><strong
										style="color: red;">*</strong> Nomenclature</label>
								</div>
								<div class="col-md-8">
									<input type="text" id="nomenclature" name="nomenclature"
										class="form-control autocomplete"
										style="text-transform: uppercase" autocomplete="off">
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-12">
						<div class="col-md-6">
							<div class="row form-group">
								<div class="col-md-4">
									<label for="text-input" class=" form-control-label"><strong
										style="color: red;">*</strong>Quantity Held</label>
								</div>

								<div class="col-md-8">
									<input type="text" id="qty" name="qty"
										class="form-control autocomplete" maxlength="2"
										style="text-transform: uppercase" autocomplete="off">
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="row form-group">
								<div class="col-md-4">
									<label for="text-input" class=" form-control-label"><strong
										style="color: red;">*</strong> Ledger no</label>
								</div>
								<div class="col-md-8">
									<input type="text" id="ledger_no" name="ledger_no"
										class="form-control autocomplete"
										style="text-transform: uppercase" autocomplete="off">
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="card-footer" align="center" class="form-control">
					<a href=Stock_masterUrl class="btn btn-success btn-sm">Clear</a> <input
						type="submit" class="btn btn-primary btn-sm" value="Save"
						onclick="return Validate();"> <i class="fa fa-search"></i><input
						type="button" class="btn btn-info btn-sm" id="btn-reload"
						value="Search">

				</div>
			</div>
		</div>
	</div>

	<div class="container">
		<table id="getSpareASearch" class="display">
			<thead>
				<tr>

					<th>part_no</th>
					<!-- <th>Nomenclature</th> -->
					<th>Quantity Held</th>
					<th>Ledger no</th>
					<th>Action</th>
				</tr>
			</thead>
		</table>
	</div>

</form:form>

<%-- <c:url value="Edit_Stock_Url" var="Edit_Stock_Url" />
<form:form action="${Edit_Literature_Url}" method="post" id="updateForm"
	name="updateForm" modelAttribute="id1">
	<input type="hidden" name="id1" id="id1" value="0" />
</form:form>

<c:url value="Delete_Stock" var="delete_Url" />
<form:form action="${delete_Url}" method="post" id="deleteForm"
	name="deleteForm" modelAttribute="id2">
	<input type="hidden" name="id2" id="id2" value="0" />
</form:form>  --%>

<script type="text/javascript">
	function data(getSpareASearch) {
		jsondata = [];

		var table = $('#' + getSpareASearch).DataTable();
		var info = table.page.info();
		var currentPage = info.page;
		var pageLength = info.length;
		var startPage = info.start;
		var endPage = info.end;
		var Search = table.search();
		var order = table.order();
		var orderColunm = $(table.column(order[0][0]).header()).html()
				.toLowerCase();
		var orderType = order[0][1];

		var part_no = $("#part_no").val();
		var qty = $("#qty").val();
		var ledger_no = $("#ledger_no").val();

		$.post("getFilterSpare_A?" + key + "=" + value, {
			startPage : startPage,
			pageLength : pageLength,
			Search : Search,
			orderColunm : orderColunm,
			orderType : orderType,
			part_no : part_no
		}, function(j) {
			for (var i = 0; i < j.length; i++) {
				jsondata.push([ j[i].part_no, j[i].qty, j[i].ledger_no,
						j[i].action ]);
			}

		});
		$.post("getTotalSpare_ACount?" + key + "=" + value, {
			Search : Search,
			part_no : part_no
		}, function(j) {
			FilteredRecords = j;
		});
	}
</script>

<script type="text/javascript">
	$(document).ready(function() {

		mockjax1('getSpareASearch');
		table = dataTable('getSpareASearch');
		$('#btn-reload').on('click', function() {
			table.ajax.reload();
		});
	});

	function Validate() {
		/* if ($("select#veh_id").val() == 0) {
			alert("Please Select Veh/Eqpt Type");
			$("select#veh_id").focus();
			return false;
		}
		if ($("input#lite_name").val() == "") {
			alert("Please Enter Literature Name");
			$("input#lite_name").focus();
			return false;
		}
		if ($("input#lite_part_no").val() == "") {
			alert("Please Enter Part No");
			$("input#lite_part_no").focus();
			return false;
		}
		
		return true; */
	}

	function Validate() {
		if ($("input#part_no").val() == "") {
			alert("Please Enter part_no");
			$("input#part_no").focus();

			return false;
		}
	}
	function editData(id) {
		$("input#id1").val(id);
		document.getElementById('updateForm').submit();
	}

	function deleteData(id) {
		$("#id2").val(id);
		document.getElementById('deleteForm').submit();
	}

	$("input#part_no")
			.keypress(
					function() {

						var part_no = this.value;
						var wepetext = $("#part_no");
						wepetext
								.autocomplete({
									source : function(request, response) {
										$
												.ajax({
													type : 'POST',
													url : "getPartNoListfromSpareA?"
															+ key + "=" + value,
													data : {
														sp_part_no : part_no
													},
													success : function(data) {
														var codeval = [];
														var length = data.length - 1;
														var enc = data[length]
																.substring(0,
																		16);
														for (var i = 0; i < data.length; i++) {
															codeval.push(dec(
																	enc,
																	data[i]));
														}
														var dataCountry1 = codeval
																.join("|");
														var myResponse = [];
														var autoTextVal = wepetext
																.val();
														$
																.each(
																		dataCountry1
																				.toString()
																				.split(
																						"|"),
																		function(
																				i,
																				e) {
																			var newE = e
																					.substring(
																							0,
																							autoTextVal.length);
																			if (e
																					.toLowerCase()
																					.includes(
																							autoTextVal
																									.toLowerCase())) {
																				myResponse
																						.push(e);
																			}
																		});
														response(myResponse);
													}
												});
									},
									minLength : 1,
									autoFill : true,
									change : function(event, ui) {
										if (ui.item) {
											return true;
										}
									},
									select : function(event, ui) {
										var nom = ui.item.value;

										$.post("getNomenFrompartnoA?" + key
												+ "=" + value, {
											sp_part_no : nom
										}, function(j) {
											var length = j.length - 1;
											var enc = j[length]
													.substring(0, 16);
											$("#nomenclature").val(
													dec(enc, j[0]));
										});
									}

								});
					});

	$("input#nomenclature")
			.keypress(
					function() {

						var nomenclature = this.value;
						var wepetext = $("#nomenclature");
						wepetext
								.autocomplete({
									source : function(request, response) {
										$
												.ajax({
													type : 'POST',
													url : "getNomenListfromSpareA?"
															+ key + "=" + value,
													data : {
														nomenclature : nomenclature
													},
													success : function(data) {
														var codeval = [];
														var length = data.length - 1;
														var enc = data[length]
																.substring(0,
																		16);
														for (var i = 0; i < data.length; i++) {
															codeval.push(dec(
																	enc,
																	data[i]));
														}
														var dataCountry1 = codeval
																.join("|");
														var myResponse = [];
														var autoTextVal = wepetext
																.val();
														$
																.each(
																		dataCountry1
																				.toString()
																				.split(
																						"|"),
																		function(
																				i,
																				e) {
																			var newE = e
																					.substring(
																							0,
																							autoTextVal.length);
																			if (e
																					.toLowerCase()
																					.includes(
																							autoTextVal
																									.toLowerCase())) {
																				myResponse
																						.push(e);
																			}
																		});
														response(myResponse);
													}
												});
									},
									minLength : 1,
									autoFill : true,
									change : function(event, ui) {
										if (ui.item) {
											return true;
										}
									},
									select : function(event, ui) {
										var nom = ui.item.value;

										$.post("getpartnoFromNomenA?" + key
												+ "=" + value, {
											sp_nomen : nom
										}, function(j) {
											debugger;
											var length = j.length - 1;
											var enc = j[length]
													.substring(0, 16);
											$("#part_no").val(dec(enc, j[0]));
										});
									}

								});
					});
</script>
