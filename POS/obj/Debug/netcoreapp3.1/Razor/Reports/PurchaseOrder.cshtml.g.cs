#pragma checksum "D:\POS\POS\POS\Reports\PurchaseOrder.cshtml" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "c2e062cc9867db0309e2e7c6e0d6f81dd3487603"
// <auto-generated/>
#pragma warning disable 1591
[assembly: global::Microsoft.AspNetCore.Razor.Hosting.RazorCompiledItemAttribute(typeof(AspNetCore.Reports_PurchaseOrder), @"mvc.1.0.view", @"/Reports/PurchaseOrder.cshtml")]
namespace AspNetCore
{
    #line hidden
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Threading.Tasks;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.AspNetCore.Mvc.Rendering;
    using Microsoft.AspNetCore.Mvc.ViewFeatures;
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"c2e062cc9867db0309e2e7c6e0d6f81dd3487603", @"/Reports/PurchaseOrder.cshtml")]
    public class Reports_PurchaseOrder : global::Microsoft.AspNetCore.Mvc.Razor.RazorPage<dynamic>
    {
        #line hidden
        #pragma warning disable 0649
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperExecutionContext __tagHelperExecutionContext;
        #pragma warning restore 0649
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperRunner __tagHelperRunner = new global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperRunner();
        #pragma warning disable 0169
        private string __tagHelperStringValueBuffer;
        #pragma warning restore 0169
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperScopeManager __backed__tagHelperScopeManager = null;
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperScopeManager __tagHelperScopeManager
        {
            get
            {
                if (__backed__tagHelperScopeManager == null)
                {
                    __backed__tagHelperScopeManager = new global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperScopeManager(StartTagHelperWritingScope, EndTagHelperWritingScope);
                }
                return __backed__tagHelperScopeManager;
            }
        }
        private global::Microsoft.AspNetCore.Mvc.Razor.TagHelpers.HeadTagHelper __Microsoft_AspNetCore_Mvc_Razor_TagHelpers_HeadTagHelper;
        private global::Microsoft.AspNetCore.Mvc.Razor.TagHelpers.BodyTagHelper __Microsoft_AspNetCore_Mvc_Razor_TagHelpers_BodyTagHelper;
        #pragma warning disable 1998
        public async override global::System.Threading.Tasks.Task ExecuteAsync()
        {
            WriteLiteral("<!DOCTYPE html>\r\n<html>\r\n");
            __tagHelperExecutionContext = __tagHelperScopeManager.Begin("head", global::Microsoft.AspNetCore.Razor.TagHelpers.TagMode.StartTagAndEndTag, "c2e062cc9867db0309e2e7c6e0d6f81dd34876032691", async() => {
                WriteLiteral(@"

    <link rel=""preconnect"" href=""https://fonts.gstatic.com"">
    <link href=""https://fonts.googleapis.com/css2?family=IBM+Plex+Sans&display=swap"" rel=""stylesheet"">
    <style>
        body {
            font-family: 'IBM Plex Sans', sans-serif;
        }
        ");
                WriteLiteral("@media print {\r\n            h1 {\r\n                page-break-before: always;\r\n            }\r\n        }\r\n\r\n        ");
                WriteLiteral(@"@font-face {
            font-family: IDAutomationHC39M;
            src: url(http://localhost:44317/IDAutomationHC39M.woff);
        }

        #students {
            font-family: 'IBM Plex Sans', sans-serif;
            border-collapse: collapse;
            width: 100%;
        }

            #students td, #students th {
                border: 1px dashed #000000;
                border-collapse: collapse;

                padding: 8px 8px 8px 8px;
            }

            /*#customers tr:nth-child(even){background-color: #f2f2f2;}*/

            /*#customers tr:hover {background-color: #ddd;}*/

            #students th {
                padding-top: 12px;
                padding-bottom: 12px;
                text-align: left;
                /*  background-color: #373737;
                color: white;*/
                color: #373737;
            }

        img {
            width: 70px;
            height: 70px;
        }

        .center {
            margin: aut");
                WriteLiteral(@"o;
            /*  margin: 3rem 5rem 2rem 0rem;*/
            /*margin-right: auto;*/
        }
        .header {
          
            /*  margin: 3rem 5rem 2rem 0rem;*/
            /*margin-right: auto;*/
        }
        #head_table {
            border-collapse: collapse;
            margin: 2rem 5rem 2rem 0rem; /* top=1em, right=2em, bottom=3em, left=2em */
        }

            #head_table td {
                padding: 8px 8px 8px 8px;
            }


        #scissors {
            height: 100px; /* image height */
            width: 100%;
          
            background-image: url('http://i.stack.imgur.com/cXciH.png');
            background-size:20px;
            background-repeat: no-repeat;
            background-position: center;
            position: relative;
            overflow: hidden;
        }

            #scissors:after {
                content: """";
                position: relative;
                top: 50%;
                display: block;
     ");
                WriteLiteral("           border-top: 1px dashed black;\r\n                margin-top: -1px;\r\n            }\r\n    </style>\r\n");
            }
            );
            __Microsoft_AspNetCore_Mvc_Razor_TagHelpers_HeadTagHelper = CreateTagHelper<global::Microsoft.AspNetCore.Mvc.Razor.TagHelpers.HeadTagHelper>();
            __tagHelperExecutionContext.Add(__Microsoft_AspNetCore_Mvc_Razor_TagHelpers_HeadTagHelper);
            await __tagHelperRunner.RunAsync(__tagHelperExecutionContext);
            if (!__tagHelperExecutionContext.Output.IsContentModified)
            {
                await __tagHelperExecutionContext.SetOutputContentAsync();
            }
            Write(__tagHelperExecutionContext.Output);
            __tagHelperExecutionContext = __tagHelperScopeManager.End();
            WriteLiteral("\r\n");
            __tagHelperExecutionContext = __tagHelperScopeManager.Begin("body", global::Microsoft.AspNetCore.Razor.TagHelpers.TagMode.StartTagAndEndTag, "c2e062cc9867db0309e2e7c6e0d6f81dd34876036367", async() => {
                WriteLiteral(@"

    <div>
        <div style=""overflow:hidden;"">
            <div class=""header"" style=""width:50%; float:left;"">
                <table class=""header"">

                    <thead>
                        <tr style=""text-align:center;"">
                            <th style=""padding: 8px 8px 8px 8px;""><img src=""http://localhost:44317/martlogo.png"" alt=""Image"" /></th>
                            <th style="" text-align: center;padding: 8px 8px 8px 8px;"">
                                <div style=""text-align:center;  "">
                                    <h1>NICEBAZAAR</h1>
                                </div>
                            </th>
                        </tr>

                    </thead>
                </table>
                <table class=""header"">
                    <tr><td style=""text-align:center; font-size:12px ; ""> Software Technology Park(Janata Tower), Level-8, 49 Kawran Bazar Rd, Dhaka 1215 </td></tr>
                </table>


            </div>
         ");
                WriteLiteral(@"   <div class=""header"" style=""width:50%; float:right; text-align:right;"">

                <h3 style="" border: 2px solid #000000; color: #ffffff; background-color: #000000; text-align: center;"">Purchase Order</h3>
                <div style="" text-align: right;
        margin: 2rem 0rem 0rem 0rem;"">
                    <strong> Date : </strong> ");
#nullable restore
#line 125 "D:\POS\POS\POS\Reports\PurchaseOrder.cshtml"
                                         Write(Model.Purchase.entry_date.ToString("dd/MM/yy"));

#line default
#line hidden
#nullable disable
                WriteLiteral("\r\n                </div>\r\n                <div style=\" text-align: right;\r\n        margin: 2rem 0rem 0rem 0rem;\">\r\n                    <strong> Invoice No. : </strong> ");
#nullable restore
#line 129 "D:\POS\POS\POS\Reports\PurchaseOrder.cshtml"
                                                Write(Model.Purchase.invoice);

#line default
#line hidden
#nullable disable
                WriteLiteral(@"
                </div>

            </div>
        </div>


        <div style=""overflow: hidden;"">
            <div style=""width: 50%; float: left; "">
                <table id=""head_table"">


                    <tr>
                        <td><strong> Payment By : </strong></td>
                    </tr>
                    <tr>
                        <td> User </td>

                    </tr>
                    <tr>

                        <td>User ID</td>


                    </tr>
                    <tr>

                        <td>User Phone</td>

                    </tr>
                    <tr>

                        <td><strong>Payment Method : </strong></td>
                        <td> Bank or Cash </td>
                    </tr>
                </table>
            </div>
            <div style=""width: 50%; float: right; text-align:left;"">
                <table id=""head_table"">


                    <tr>
                        <td><strong> Pa");
                WriteLiteral("yment To : </strong></td>\r\n\r\n\r\n                    </tr>\r\n                    <tr>\r\n                        <td>");
#nullable restore
#line 176 "D:\POS\POS\POS\Reports\PurchaseOrder.cshtml"
                       Write(Model.Supplier.name);

#line default
#line hidden
#nullable disable
                WriteLiteral("</td>\r\n\r\n                    </tr>\r\n                    <tr>\r\n\r\n                        <td>");
#nullable restore
#line 181 "D:\POS\POS\POS\Reports\PurchaseOrder.cshtml"
                       Write(Model.Supplier.company);

#line default
#line hidden
#nullable disable
                WriteLiteral("</td>\r\n\r\n                    </tr>\r\n                    <tr>\r\n\r\n                        <td>");
#nullable restore
#line 186 "D:\POS\POS\POS\Reports\PurchaseOrder.cshtml"
                       Write(Model.Supplier.address);

#line default
#line hidden
#nullable disable
                WriteLiteral(", ");
#nullable restore
#line 186 "D:\POS\POS\POS\Reports\PurchaseOrder.cshtml"
                                                Write(Model.Supplier.thana);

#line default
#line hidden
#nullable disable
                WriteLiteral(", ");
#nullable restore
#line 186 "D:\POS\POS\POS\Reports\PurchaseOrder.cshtml"
                                                                       Write(Model.Supplier.district);

#line default
#line hidden
#nullable disable
                WriteLiteral("</td>\r\n\r\n                    </tr>\r\n                    <tr>\r\n\r\n                        <td>");
#nullable restore
#line 191 "D:\POS\POS\POS\Reports\PurchaseOrder.cshtml"
                       Write(Model.Supplier.mobile);

#line default
#line hidden
#nullable disable
                WriteLiteral(@"</td>

                    </tr>

                </table>
            </div>

        </div>
    </div>




    <table id=""students"">
        <thead>
            <tr>

                <th>SL</th>
                <th>ITEM</th>
                <th>Unit Price</th>
                <th>Quantity</th>
                <th>Total Price</th>

            </tr>
        </thead>
");
#nullable restore
#line 216 "D:\POS\POS\POS\Reports\PurchaseOrder.cshtml"
           int i = 1;

#line default
#line hidden
#nullable disable
#nullable restore
#line 217 "D:\POS\POS\POS\Reports\PurchaseOrder.cshtml"
         foreach (var s in Model.Purchase.purchase_list)
        {


#line default
#line hidden
#nullable disable
                WriteLiteral("            <tr>\r\n                <td>");
#nullable restore
#line 221 "D:\POS\POS\POS\Reports\PurchaseOrder.cshtml"
                Write(i++);

#line default
#line hidden
#nullable disable
                WriteLiteral("</td>\r\n                <td>");
#nullable restore
#line 222 "D:\POS\POS\POS\Reports\PurchaseOrder.cshtml"
               Write(s.product_name);

#line default
#line hidden
#nullable disable
                WriteLiteral("</td>\r\n                <td>");
#nullable restore
#line 223 "D:\POS\POS\POS\Reports\PurchaseOrder.cshtml"
               Write(s.quantity);

#line default
#line hidden
#nullable disable
                WriteLiteral("</td>\r\n                <td>");
#nullable restore
#line 224 "D:\POS\POS\POS\Reports\PurchaseOrder.cshtml"
               Write(s.unit_price);

#line default
#line hidden
#nullable disable
                WriteLiteral("</td>\r\n                <td>");
#nullable restore
#line 225 "D:\POS\POS\POS\Reports\PurchaseOrder.cshtml"
                Write(s.quantity * s.unit_price);

#line default
#line hidden
#nullable disable
                WriteLiteral("</td>\r\n\r\n            </tr>\r\n");
#nullable restore
#line 228 "D:\POS\POS\POS\Reports\PurchaseOrder.cshtml"

        }

#line default
#line hidden
#nullable disable
                WriteLiteral("\r\n\r\n        <tr>\r\n\r\n            <td colspan=\"4\" style=\"border: 0px ; text-align:end;\">Net Total</td>\r\n            <td colspan=\"1\"> ");
#nullable restore
#line 235 "D:\POS\POS\POS\Reports\PurchaseOrder.cshtml"
                        Write(Model.Purchase.payment);

#line default
#line hidden
#nullable disable
                WriteLiteral("</td>\r\n\r\n        </tr>\r\n        <tr>\r\n            <td rowspan=\"2\" colspan=\"3\" style=\"font-size:15pt ; font-family: IDAutomationHC39M; text-align:left; align-content:center; border:0px;\">*");
#nullable restore
#line 239 "D:\POS\POS\POS\Reports\PurchaseOrder.cshtml"
                                                                                                                                                Write(Model.Purchase.invoice);

#line default
#line hidden
#nullable disable
                WriteLiteral("*</td>\r\n            <td style=\"border: 0px ; text-align:end;\">Discount</td>\r\n            <td >");
#nullable restore
#line 241 "D:\POS\POS\POS\Reports\PurchaseOrder.cshtml"
            Write(Model.Purchase.discount);

#line default
#line hidden
#nullable disable
                WriteLiteral("</td>\r\n\r\n        </tr>\r\n        <tr>\r\n            <td  style=\"border: 0px ; text-align:end;\">Paid</td>\r\n            <td >");
#nullable restore
#line 246 "D:\POS\POS\POS\Reports\PurchaseOrder.cshtml"
            Write(Model.Purchase.total);

#line default
#line hidden
#nullable disable
                WriteLiteral("</td>\r\n\r\n        </tr>\r\n\r\n    </table>\r\n\r\n\r\n    <div id=\"scissors\"></div>\r\n\r\n\r\n\r\n");
            }
            );
            __Microsoft_AspNetCore_Mvc_Razor_TagHelpers_BodyTagHelper = CreateTagHelper<global::Microsoft.AspNetCore.Mvc.Razor.TagHelpers.BodyTagHelper>();
            __tagHelperExecutionContext.Add(__Microsoft_AspNetCore_Mvc_Razor_TagHelpers_BodyTagHelper);
            await __tagHelperRunner.RunAsync(__tagHelperExecutionContext);
            if (!__tagHelperExecutionContext.Output.IsContentModified)
            {
                await __tagHelperExecutionContext.SetOutputContentAsync();
            }
            Write(__tagHelperExecutionContext.Output);
            __tagHelperExecutionContext = __tagHelperScopeManager.End();
            WriteLiteral("\r\n</html>");
        }
        #pragma warning restore 1998
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.ViewFeatures.IModelExpressionProvider ModelExpressionProvider { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.IUrlHelper Url { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.IViewComponentHelper Component { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.Rendering.IJsonHelper Json { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.Rendering.IHtmlHelper<dynamic> Html { get; private set; }
    }
}
#pragma warning restore 1591
