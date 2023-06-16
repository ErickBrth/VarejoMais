package com.example.varejo_mais;

import io.flutter.embedding.android.FlutterActivity;

import rede.smartrede.sdk.RedePayments;
import rede.smartrede.sdk.FlexTipoPagamento;
import rede.smartrede.sdk.Payment;
import rede.smartrede.sdk.PaymentStatus;
import rede.smartrede.sdk.Receipt;
import rede.smartrede.sdk.RedePaymentValidationError;

import android.os.Bundle;

public class MainActivity extends FlutterActivity {

    public static final String TAG = "varejo_mais";
    private RedePayments redePayments;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        redePayments = RedePayments.getInstance(this);
    }


}
