(define (assoc key records)
  (cond ((null? records) #f)
        ((equal? key (caar records)) (car records))
        (else (assoc key (cdr records)))))

(define (insert! key value table)
    (let ((record (assoc key (cdr table))))
        (if record
            (set-cdr! record value)
            (set-cdr! table (cons (cons key value) (cdr table)))))
    'ok)

(define (lookup key table)
  (let ((record (assoc key (cdr table))))
    (if record
        (cdr record)
        #f)))

(define (make-table)
    (list '*table*))

; (define (lookup key-1 key-2 table)
;   (let ((subtable (assoc key-1 (cdr table))))
;     (if subtable
;         (let ((record (assoc key-2 (cdr subtable))))
;           (if record
;               (cdr record)
;               #f)
;           #f))))

; (define (insert! key-1 key-2 value table)
;     (let ((subtable (assoc key-1 (cdr table))))
;         (if subtable
;             (let ((record (assoc key-2 (cdr subtable))))
;             (if record
;                 (set-cdr! record value)
;                 (set-cdr! subtable (cons (cons key-2 value) (cdr subtable))))
;             (set-cdr! table (cons (list key-1 (cons key-2 value)) (cdr table))))))
;     'ok)

(define (fib n)
    (cond ((= n 0) 0)
          ((= n 1) 1)
          (else (+ (fib (- n 1)) (fib (- n 2))))))

(define (memoize f)
    (let ((table (make-table)))
        (lambda (x)
            (let ((previously-computed-result (lookup x table)))
                (or previously-computed-result
                    (let ((result (f x)))
                        (insert! x result table)
                        result))))))

(define memo-fib
    (memoize (lambda (n)
        (cond ((= n 0) 0)
              ((= n 1) 1)
              (else (+ (memo-fib (- n 1)) (memo-fib (- n 2))))))))