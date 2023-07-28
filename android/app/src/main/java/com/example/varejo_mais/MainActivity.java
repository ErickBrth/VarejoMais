package com.example.varejo_mais;

import io.flutter.embedding.android.FlutterActivity;

import static android.widget.Toast.LENGTH_LONG;
import static android.widget.Toast.LENGTH_SHORT;


import android.app.Activity;
import android.content.ActivityNotFoundException;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.util.Log;

import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.Locale;

import io.flutter.plugins.GeneratedPluginRegistrant;
import rede.smartrede.sdk.Payment;
import rede.smartrede.sdk.PaymentStatus;
import rede.smartrede.sdk.Receipt;
import rede.smartrede.sdk.RedePayments;
import rede.smartrede.sdk.FlexTipoPagamento;
import rede.smartrede.sdk.RedePaymentValidationError;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

import android.os.Bundle;
import android.widget.TextView;
import android.widget.Toast;

public class MainActivity extends FlutterActivity {

    public static final String TAG = "Varejo+";

    public static final int REQ_CODE_PAYMENT = 1;

    public static final int REQ_CODE_REPRINT = 2;

    public static final int REQ_CODE_REVERSAL = 3;

    private static final String MONEY_PATTERN = "###,###,##0.00";

    private RedePayments redePayments;

    private static final DecimalFormat moneyFormat = new DecimalFormat(MONEY_PATTERN,
            DecimalFormatSymbols.getInstance(new Locale("pt", "BR")));

    private final String CHANNEL = "unique.identifier.method/hello";
    private final String CHANNEL1 = "unique.identifier.method/getLongAmount";
//    private final String CREDIT_CARD = "unique.identifier.method/creditoParcelado";

    private final String REPRINT = "unique.identifier.method/reprint";
    private final String CREDITO_PARCELADO_EMISSOR = "unique.identifier.method/creditoParceladoEmissor";
    private final String CREDITO_A_VISTA = "unique.identifier.method/creditoVista";
    private final String CARTAO_DEBITO = "unique.identifier.method/debito";
    private final String VOUCHER = "unique.identifier.method/voucher";
    private final String REVERSAL = "unique.identifier.method/estorno";



    private TextView PVNumberText;

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        MethodChannel reprint = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), REPRINT);
        reprint.setMethodCallHandler((call, result) -> {

            if(call.method.equals("reprint")){
                result.success(reprint());
            }else{
                result.notImplemented();
            }

        });

        MethodChannel CreditoParceladoEmissor = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CREDITO_PARCELADO_EMISSOR);
        CreditoParceladoEmissor.setMethodCallHandler((call, result) -> {

            if(call.method.equals("creditoParceladoEmissor")){
                result.success(creditoParceladoEmissor());
            }else{
                result.notImplemented();
            }
        });

        MethodChannel creditoVista = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CREDITO_A_VISTA);
        creditoVista.setMethodCallHandler((call, result) -> {

            if(call.method.equals("creditoVista")){
                result.success(creditoVista());
            }else{
                result.notImplemented();
            }
        });

        MethodChannel debito = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CARTAO_DEBITO);
        debito.setMethodCallHandler((call, result) -> {

            if(call.method.equals("debito")){
                result.success(debito());
            }else{
                result.notImplemented();
            }
        });

        MethodChannel voucher = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), VOUCHER);
        voucher.setMethodCallHandler((call, result) -> {

            if(call.method.equals("voucher")){
                result.success(voucher());
            }else{
                result.notImplemented();
            }
        });

        MethodChannel estorno = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), REVERSAL);
        estorno.setMethodCallHandler((call, result) -> {

            if(call.method.equals("estorno")){
                result.success(estorno());
            }else{
                result.notImplemented();
            }
        });

    }
    public String reprint(){
        onReprint();
        return "printa";
    }


    public String creditoParceladoEmissor(){
        openPaymentFragmentCreditoEmissor();
        return "ok!";
    }

    public String creditoVista(){
        openPaymentFragmentCreditoVista();
        return "ok!";
    }

    public String debito(){
        openPaymentDebit();
        return "ok!";
    }

    public String voucher(){
        openPaymentVoucher();
        return "ok!";
    }

    public String estorno(){
        onReversal();
        return "ok!";
    }


    private BroadcastReceiver mBroadcastReceiver = new BroadcastReceiver() {

        @Override
        public void onReceive(Context context, Intent intent) {
            Bundle args = intent.getExtras();
            String s = args.getString("PVNumber");
            if (PVNumberText != null) {
                PVNumberText.setText(s);
            }
        }
    };


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        redePayments = RedePayments.getInstance(this);


        setTitle(getString(R.string.app_name) + " v" + BuildConfig.VERSION_NAME);
        GeneratedPluginRegistrant.registerWith(new FlutterEngine(this));


    }

    //crédito parcelado sem juros

//    public void openPaymentFragment() {
//        hideReceipt();
//        try {
//            Intent collectPaymentIntent = redePayments
//                    .intentForPaymentBuilder(FlexTipoPagamento.CREDITO_PARCELADO,
//                            getLongAmount())
//                    .setInstallments(4)
//                    .build();
//            startActivityForResult(collectPaymentIntent, REQ_CODE_PAYMENT);
//        } catch (ActivityNotFoundException ex) {
//            Log.e("Varejo+ ", "Poynt Payment Activity not found - did you install PoyntServices?");
//        } catch (RedePaymentValidationError redePaymentValidationError) {
//            Toast.makeText(this, redePaymentValidationError.getMessage(),
//                    LENGTH_LONG).show();
//        }
//    }

    //crédito parcelado com juros
    public void openPaymentFragmentCreditoEmissor() {
        hideReceipt();
        try {
            Intent collectPaymentIntent = redePayments.intentForPaymentBuilder(
                            FlexTipoPagamento.CREDITO_PARCELADO_EMISSOR, getLongAmount())
                    .setInstallments(4)
                    .build();
            startActivityForResult(collectPaymentIntent, REQ_CODE_PAYMENT);
        } catch (ActivityNotFoundException ex) {
            Log.e("Varejo+", "Poynt Payment Activity not found - did you install PoyntServices?");
        } catch (RedePaymentValidationError redePaymentValidationError){
            Toast.makeText(this, redePaymentValidationError.getMessage(), LENGTH_LONG).show();
        }
    }

    public void openPaymentFragmentCreditoVista() {
        hideReceipt();
        try {
            Intent collectPaymentIntent = redePayments.intentForPaymentBuilder(
                            FlexTipoPagamento.CREDITO_A_VISTA, getLongAmount())
                    .build();
            startActivityForResult(collectPaymentIntent, REQ_CODE_PAYMENT);
        } catch (ActivityNotFoundException ex) {
            Log.e("Varejo+", "Poynt Payment Activity not found - did you install PoyntServices?");
        } catch (RedePaymentValidationError redePaymentValidationError){
            Toast.makeText(this, redePaymentValidationError.getMessage(), LENGTH_LONG).show();
        }
    }

    public void openPaymentPix() {
        hideReceipt();
        try {
            Intent collectPaymentIntent = redePayments.intentForPaymentBuilder(
                            FlexTipoPagamento.PIX, getLongAmount())
                    .build();
            startActivityForResult(collectPaymentIntent, REQ_CODE_PAYMENT);
        } catch (ActivityNotFoundException ex) {
            Log.e("Varejo+", "Poynt Payment Activity not found - did you install PoyntServices?");
        } catch (RedePaymentValidationError redePaymentValidationError){
            Toast.makeText(this, redePaymentValidationError.getMessage(), LENGTH_LONG).show();
        }
    }

    public void openPaymentDebit() {
        hideReceipt();
        try {
            Intent collectPaymentIntent = redePayments.intentForPaymentBuilder(
                            FlexTipoPagamento.DEBITO, getLongAmount())
                    .build();
            startActivityForResult(collectPaymentIntent, REQ_CODE_PAYMENT);
        } catch (ActivityNotFoundException ex) {
            Log.e("Varejo+", "Poynt Payment Activity not found - did you install PoyntServices?");
        } catch (RedePaymentValidationError redePaymentValidationError){
            Toast.makeText(this, redePaymentValidationError.getMessage(), LENGTH_LONG).show();
        }
    }

    public void openPaymentVoucher() {
        hideReceipt();
        try {
            Intent collectPaymentIntent = redePayments.intentForPaymentBuilder(
                            FlexTipoPagamento.VOUCHER, getLongAmount())
                    .build();
            startActivityForResult(collectPaymentIntent, REQ_CODE_PAYMENT);
        } catch (ActivityNotFoundException ex) {
            Log.e("Varejo+", "Poynt Payment Activity not found - did you install PoyntServices?");
        } catch (RedePaymentValidationError redePaymentValidationError){
            Toast.makeText(this, redePaymentValidationError.getMessage(), LENGTH_LONG).show();
        }
    }

    private int getLongAmount() { //receber valor da compra
        //TODO
        int amount = 500;

        // String amountString = ((EditText)
        // findViewById(R.id.valor)).getText().toString();
        // if (!TextUtils.isEmpty(amountString)) {
        // amount = Integer.parseInt(amountString);
        // }
        return amount;
    }

    private void hideReceipt(){ // ocultar receita(NF)
       // RelativeLayout rl = findViewById(R.id.rlReceipt);
        //rl.setVisibility(View.GONE);
    }

    @Override
    public void onResume(){
        super.onResume();
        registerReceiver(mBroadcastReceiver, new IntentFilter("br.com.mobilerede.GetPVNumber"));
    }

    @Override
    public void onPause(){
        super.onPause();
        unregisterReceiver(mBroadcastReceiver);
    }

    public void onReprint() {
        hideReceipt();
        try {
            Intent reprint = redePayments.intentForReprint();
            startActivityForResult(reprint, REQ_CODE_REPRINT);
        } catch(ActivityNotFoundException ex) {
            Log.e("Varejo+", "Poynt Payment Activity not found - did you install PoyntServices?");
        } catch (RedePaymentValidationError redePaymentValidationError){
            Toast.makeText(this, redePaymentValidationError.getMessage(), LENGTH_LONG).show();
        }
    }

    public void onReversal() {
        hideReceipt();
        try {
            Intent reversal = redePayments.intentForReversal();
            startActivityForResult(reversal, REQ_CODE_REVERSAL);
        } catch(ActivityNotFoundException ex) {
            Log.e("Varejo+", "Poynt Payment Activity not found - did you install PoyntServices?");
        }
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        hideReceipt();
        String s = "";
        switch(requestCode){
            case REQ_CODE_PAYMENT:
                if(resultCode== Activity.RESULT_OK){
                    Payment payment = RedePayments.getPaymentFromIntent(data);
                    if (payment.getStatus() == PaymentStatus.AUTHORIZED) {
                        Receipt receipt = payment.getReceipt();
                        s = "Payment Authorized\n";
                        s += "Valor: $" + moneyFormat.format(payment.getAmount() / 100d);
                        showReceipt(receipt);
                        Toast.makeText(this, s, LENGTH_LONG).show();
                    } else {
                        String msg = "Resultado da transação:\n" + getPaymentStatus(data);
                        Toast.makeText(this, msg, LENGTH_LONG).show();
                    }
                } else if (resultCode==Activity.RESULT_CANCELED) {
                    Toast.makeText(this, "Payment Canceled", LENGTH_SHORT).show();
                }
                break;

            case(REQ_CODE_REPRINT):
                if(resultCode==Activity.RESULT_OK) {
                    Toast.makeText(this, "Reimpressão OK", LENGTH_LONG).show();
                } else {
                    Toast.makeText(this, "Reimpressão cancelada", LENGTH_SHORT).show();
                }
                break;

            case(REQ_CODE_REVERSAL):
                if(resultCode==Activity.RESULT_OK) {
                    s = "Estorno de pagamento\n" + getPaymentStatus(data);
                    Toast.makeText(this, s, LENGTH_LONG).show();
                } else {
                    Toast.makeText(this, "Estorno cancelado", LENGTH_SHORT).show();
                }
                break;
        }
    }

    private @NonNull String getPaymentStatus(@Nullable Intent intent) {
        String result = "Sem objeto Payment";
        if (intent != null) {
            Payment payment = RedePayments.getPaymentFromIntent(intent);
            if (payment != null) {
                PaymentStatus status = payment.getStatus();
                if (status != null) {
                    result = status.toString();
                } else {
                    result = "Sem status no Payment";
                }
            }
        }
        return result;
    }

    private String showReceipt(Receipt receipt){
        //todo
        String result ="";
        result += "CNPJ: "+ receipt.getCNPJ() +
                " ///nome da loja: "+ receipt.getStoreName() +
                " ///dono do cartao: "+ receipt.getCardHolderName();

        return result;
    }


}
