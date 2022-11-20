(defglobal
    ?*Q0* = "HBsAg? "
    ?*Q1* = "anti-HDV? "
    ?*Q2* = "anti-HBs? "
    ?*Q3* = "anti-HBc? "
    ?*Q4* = "lgM anti-HBc? "

    ?*A0* = "Hasil Prediksi = Hepatitis B+D"
    ?*A1* = "Hasil Prediksi = Uncertain configuration"
    ?*A2* = "Hasil Prediksi = Cured"
    ?*A3* = "Hasil Prediksi = Vaccinated"
    ?*A4* = "Hasil Prediksi = Unclear (possible resolved)"
    ?*A5* = "Hasil Prediksi = Healthy not vaccinated or suspicious"
    ?*A6* = "Hasil Prediksi = Acute infection"
    ?*A7* = "Hasil Prediksi = Chronic infection"
)

(defrule MAIN-01
    (not (init ?)) =>
        (printout t crlf ?*Q0*)
        (if(eq (read) positive)
            then(assert(HBsAg positive))
            else(assert(HBsAg negative))
        )
)

(defrule Q0-POSITIVE
    (HBsAg positive) =>
    (printout t crlf ?*Q1*)
    (if(eq (read) negative)
        then(assert(anti-HDV negative))
        else(printout t crlf ?*A0* crlf)
    )
)

(defrule Q0-NEGATIVE
    (HBsAg negative) =>
    (printout t crlf ?*Q2*)
    (if(eq (read) positive)
        then(assert(anti-HBs positive))
        else(assert(anti-HBs negative))
    )
)

(defrule Q2-POSITIVE
    (anti-HBs positive) =>
    (printout t crlf ?*Q3*)
    (if(eq (read) positive)
        then(printout t crlf ?*A2* crlf)
        else(printout t crlf ?*A3* crlf)
    )
)

(defrule Q2-NEGATIVE
    (anti-HBs negative) =>
    (printout t crlf ?*Q3*)
    (if(eq (read) positive)
        then(printout t crlf ?*A4* crlf)
        else(printout t crlf ?*A5* crlf)
    )
)

(defrule Q1-NEGATIVE
    (anti-HDV negative) =>
    (printout t crlf ?*Q3*)
    (if(eq (read) positive)
        then(assert(anti-HBc positive))
        else(printout t crlf ?*A1* crlf)
    )
)

(defrule Q3-POSITIVE
    (anti-HBc positive) =>
    (printout t crlf ?*Q2*)
    (if(eq (read) positive)
        then(printout t crlf ?*A1* crlf)
        else(assert(anti-HBs2 negative))
    )
)

(defrule Q2-NEGATIVE2
    (anti-HBs2 negative) =>
    (printout t crlf ?*Q4*)
    (if(eq (read) positive)
        then(printout t crlf ?*A6* crlf)
        else(printout t crlf ?*A7* crlf)
    )
)