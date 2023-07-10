module LibDssOpt

using DssOpt_jll
export DssOpt_jll

using CEnum

#### begin prologue.jl
# this file was autogenerated by gen/generator.jl

const UINT_MAX = typemax(Cuint)

# package versions used to generate this file
const VERSION_GEN_Clang = v"0.17.6"
const VERSION_GEN_DssOpt_jll = v"1.0.5+0"

const C_EXIT_SUCCESS = 0

#### end prologue.jl


"""
    dary_set(a, n, val)


### Prototype
```c
void dary_set(double *a, size_t n, double val);
```
"""
function dary_set(a, n, val)
    ccall((:dary_set, libdssopt), Cvoid, (Ptr{Cdouble}, Csize_t, Cdouble), a, n, val)
end

"""
    dary_equal(a, b, n)


### Prototype
```c
bool dary_equal(double *a, double *b, size_t n);
```
"""
function dary_equal(a, b, n)
    ccall((:dary_equal, libdssopt), Bool, (Ptr{Cdouble}, Ptr{Cdouble}, Csize_t), a, b, n)
end

"""
    dary_print(a, n)


### Prototype
```c
void dary_print(double *a, size_t n);
```
"""
function dary_print(a, n)
    ccall((:dary_print, libdssopt), Cvoid, (Ptr{Cdouble}, Csize_t), a, n)
end

"""
    dary_is_finite(a, n)


### Prototype
```c
bool dary_is_finite(double *a, size_t n);
```
"""
function dary_is_finite(a, n)
    ccall((:dary_is_finite, libdssopt), Bool, (Ptr{Cdouble}, Csize_t), a, n)
end

"""
    dary2d_set(n1, n2, a, val)


### Prototype
```c
void dary2d_set(size_t n1, size_t n2, double **a, double val);
```
"""
function dary2d_set(n1, n2, a, val)
    ccall((:dary2d_set, libdssopt), Cvoid, (Csize_t, Csize_t, Ptr{Ptr{Cdouble}}, Cdouble), n1, n2, a, val)
end

"""
    dary2d_equal(a, b, n1, n2)


### Prototype
```c
bool dary2d_equal(double **a, double **b, size_t n1, size_t n2);
```
"""
function dary2d_equal(a, b, n1, n2)
    ccall((:dary2d_equal, libdssopt), Bool, (Ptr{Ptr{Cdouble}}, Ptr{Ptr{Cdouble}}, Csize_t, Csize_t), a, b, n1, n2)
end

"""
    dary2d_print(a, n1, n2)


### Prototype
```c
void dary2d_print(double **a, size_t n1, size_t n2);
```
"""
function dary2d_print(a, n1, n2)
    ccall((:dary2d_print, libdssopt), Cvoid, (Ptr{Ptr{Cdouble}}, Csize_t, Csize_t), a, n1, n2)
end

"""
    dary2d_is_finite(a, n1, n2)


### Prototype
```c
bool dary2d_is_finite(double **a, size_t n1, size_t n2);
```
"""
function dary2d_is_finite(a, n1, n2)
    ccall((:dary2d_is_finite, libdssopt), Bool, (Ptr{Ptr{Cdouble}}, Csize_t, Csize_t), a, n1, n2)
end

"""
    xmalloc(size)


### Prototype
```c
void *xmalloc(size_t size);
```
"""
function xmalloc(size)
    ccall((:xmalloc, libdssopt), Ptr{Cvoid}, (Csize_t,), size)
end

"""
TODO: some typedefs not needed for C99/C++ ?, maybe should be
defined conditionally 
"""
const uchar = Cuchar

const uint = Cuint

const ulong = Culong

"""
    plogp_sane(p)

calculate p * log(p) after forcing p into the range [0.000001, 1]
this is mainly useful when p is supposed to be a probability 
### Prototype
```c
double plogp_sane(double p);
```
"""
function plogp_sane(p)
    ccall((:plogp_sane, libdssopt), Cdouble, (Cdouble,), p)
end

"""
    random_seed(seed)

seed random number generator 
### Prototype
```c
void random_seed(uint seed);
```
"""
function random_seed(seed)
    ccall((:random_seed, libdssopt), Cvoid, (uint,), seed)
end

"""
    random_get_seedval_from_current_time()

generate a seed value from the current time of day 
### Prototype
```c
uint random_get_seedval_from_current_time(void);
```
"""
function random_get_seedval_from_current_time()
    ccall((:random_get_seedval_from_current_time, libdssopt), uint, ())
end

"""
    random_seed_with_current_time()

seed random number generator with current time 
### Prototype
```c
void random_seed_with_current_time(void);
```
"""
function random_seed_with_current_time()
    ccall((:random_seed_with_current_time, libdssopt), Cvoid, ())
end

"""
    random_uint(a, b)

return uniformly distributed random uint in the interval [a, b] 
### Prototype
```c
uint random_uint(uint a, uint b);
```
"""
function random_uint(a, b)
    ccall((:random_uint, libdssopt), uint, (uint, uint), a, b)
end

"""
    random_double_uniform()

return uniformly distributed random number in the half-open
interval [0,1) 
### Prototype
```c
double random_double_uniform(void);
```
"""
function random_double_uniform()
    ccall((:random_double_uniform, libdssopt), Cdouble, ())
end

"""
    random_double_normal(mu, sigma)

normally distributed random number 
### Prototype
```c
double random_double_normal(double mu, double sigma);
```
"""
function random_double_normal(mu, sigma)
    ccall((:random_double_normal, libdssopt), Cdouble, (Cdouble, Cdouble), mu, sigma)
end

"""
    random_dvec_uniform_direction(ndim, v)

vector of length 1 with uniformly distributed direction
storage must be allocated by the caller
WARNING: the way this function is implemented at the moment, there is a
very small but nonzero probability that this function will not terminate 
### Prototype
```c
void random_dvec_uniform_direction(uint ndim, double *v);
```
"""
function random_dvec_uniform_direction(ndim, v)
    ccall((:random_dvec_uniform_direction, libdssopt), Cvoid, (uint, Ptr{Cdouble}), ndim, v)
end

"""
    x_parse_seq_constraints_hard(n, hard, constraint_str, pairs)


### Prototype
```c
uint x_parse_seq_constraints_hard(uint n, uint *hard, const char *constraint_str, const uint *pairs);
```
"""
function x_parse_seq_constraints_hard(n, hard, constraint_str, pairs)
    ccall((:x_parse_seq_constraints_hard, libdssopt), uint, (uint, Ptr{uint}, Ptr{Cchar}, Ptr{uint}), n, hard, constraint_str, pairs)
end

"""
    parse_seq_constraints_hard(n, hard, n_hard, constraint_str, verbose, pairs)


### Prototype
```c
int parse_seq_constraints_hard(uint n, uint *hard, uint *n_hard, const char *constraint_str, bool verbose, const uint *pairs);
```
"""
function parse_seq_constraints_hard(n, hard, n_hard, constraint_str, verbose, pairs)
    ccall((:parse_seq_constraints_hard, libdssopt), Cint, (uint, Ptr{uint}, Ptr{uint}, Ptr{Cchar}, Bool, Ptr{uint}), n, hard, n_hard, constraint_str, verbose, pairs)
end

"""
    run_md(vienna, seq_constraints_hard, nsteps, nprint, ncool, npur, timestep, T_start, kpi, kpa, kneg, khet, het_window, kpur_end, do_exp_cool, do_movie_output, verbose, designed_seq)

run sequence optimisation by dynamics in sequence space (dynamical
simulated annealing) 
### Prototype
```c
int run_md(const char *vienna, const char *seq_constraints_hard, uint nsteps, uint nprint, uint ncool, uint npur, double timestep, double T_start, double kpi, double kpa, double kneg, double khet, uint het_window, double kpur_end, bool do_exp_cool, bool do_movie_output, bool verbose, char ** const designed_seq);
```
"""
function run_md(vienna, seq_constraints_hard, nsteps, nprint, ncool, npur, timestep, T_start, kpi, kpa, kneg, khet, het_window, kpur_end, do_exp_cool, do_movie_output, verbose, designed_seq)
    ccall((:run_md, libdssopt), Cint, (Ptr{Cchar}, Ptr{Cchar}, uint, uint, uint, uint, Cdouble, Cdouble, Cdouble, Cdouble, Cdouble, Cdouble, uint, Cdouble, Bool, Bool, Bool, Ptr{Ptr{Cchar}}), vienna, seq_constraints_hard, nsteps, nprint, ncool, npur, timestep, T_start, kpi, kpa, kneg, khet, het_window, kpur_end, do_exp_cool, do_movie_output, verbose, designed_seq)
end

"""
    run_sd(vienna, maxsteps, nprint, wiggle, kpi, kpa, kpur, kneg, khet, het_window, do_movie_output, verbose, designed_seq)

run sequence optimisation by steepest descent 
### Prototype
```c
int run_sd(const char *vienna, uint maxsteps, uint nprint, double wiggle, double kpi, double kpa, double kpur, double kneg, double khet, uint het_window, bool do_movie_output, bool verbose, char ** const designed_seq);
```
"""
function run_sd(vienna, maxsteps, nprint, wiggle, kpi, kpa, kpur, kneg, khet, het_window, do_movie_output, verbose, designed_seq)
    ccall((:run_sd, libdssopt), Cint, (Ptr{Cchar}, uint, uint, Cdouble, Cdouble, Cdouble, Cdouble, Cdouble, Cdouble, uint, Bool, Bool, Ptr{Ptr{Cchar}}), vienna, maxsteps, nprint, wiggle, kpi, kpa, kpur, kneg, khet, het_window, do_movie_output, verbose, designed_seq)
end

"""
    dss_calc_U_pa(p, n, ndim, k)


### Prototype
```c
double dss_calc_U_pa(double **p, uint n, uint ndim, double k);
```
"""
function dss_calc_U_pa(p, n, ndim, k)
    ccall((:dss_calc_U_pa, libdssopt), Cdouble, (Ptr{Ptr{Cdouble}}, uint, uint, Cdouble), p, n, ndim, k)
end

"""
    dss_calc_gradU_pa(p, n, ndim, k, gradU)


### Prototype
```c
void dss_calc_gradU_pa(double **p, uint n, uint ndim, double k, double **gradU);
```
"""
function dss_calc_gradU_pa(p, n, ndim, k, gradU)
    ccall((:dss_calc_gradU_pa, libdssopt), Cvoid, (Ptr{Ptr{Cdouble}}, uint, uint, Cdouble, Ptr{Ptr{Cdouble}}), p, n, ndim, k, gradU)
end

"""
    dss_calc_U_pi(p, n, ndim, k)


### Prototype
```c
double dss_calc_U_pi(double **p, uint n, uint ndim, double k);
```
"""
function dss_calc_U_pi(p, n, ndim, k)
    ccall((:dss_calc_U_pi, libdssopt), Cdouble, (Ptr{Ptr{Cdouble}}, uint, uint, Cdouble), p, n, ndim, k)
end

"""
    dss_calc_gradU_pi(p, n, ndim, k, gradU)


### Prototype
```c
void dss_calc_gradU_pi(double **p, uint n, uint ndim, double k, double **gradU);
```
"""
function dss_calc_gradU_pi(p, n, ndim, k, gradU)
    ccall((:dss_calc_gradU_pi, libdssopt), Cvoid, (Ptr{Ptr{Cdouble}}, uint, uint, Cdouble, Ptr{Ptr{Cdouble}}), p, n, ndim, k, gradU)
end

"""
    dss_calc_U_pur_cauchy(p, n, ndim, kpur)


### Prototype
```c
double dss_calc_U_pur_cauchy(double **p, uint n, uint ndim, double kpur);
```
"""
function dss_calc_U_pur_cauchy(p, n, ndim, kpur)
    ccall((:dss_calc_U_pur_cauchy, libdssopt), Cdouble, (Ptr{Ptr{Cdouble}}, uint, uint, Cdouble), p, n, ndim, kpur)
end

"""
    dss_calc_gradU_pur_cauchy(p, n, ndim, kpur, gradU)


### Prototype
```c
void dss_calc_gradU_pur_cauchy(double **p, uint n, uint ndim, double kpur, double **gradU);
```
"""
function dss_calc_gradU_pur_cauchy(p, n, ndim, kpur, gradU)
    ccall((:dss_calc_gradU_pur_cauchy, libdssopt), Cvoid, (Ptr{Ptr{Cdouble}}, uint, uint, Cdouble, Ptr{Ptr{Cdouble}}), p, n, ndim, kpur, gradU)
end

"""
    dss_calc_U_negdesign_het(p, n, ndim, kneg)


### Prototype
```c
double dss_calc_U_negdesign_het(double **p, uint n, uint ndim, double kneg);
```
"""
function dss_calc_U_negdesign_het(p, n, ndim, kneg)
    ccall((:dss_calc_U_negdesign_het, libdssopt), Cdouble, (Ptr{Ptr{Cdouble}}, uint, uint, Cdouble), p, n, ndim, kneg)
end

"""
    dss_calc_gradU_negdesign_het(p, n, ndim, kneg, gradU)


### Prototype
```c
void dss_calc_gradU_negdesign_het(double **p, uint n, uint ndim, double kneg, double **gradU);
```
"""
function dss_calc_gradU_negdesign_het(p, n, ndim, kneg, gradU)
    ccall((:dss_calc_gradU_negdesign_het, libdssopt), Cvoid, (Ptr{Ptr{Cdouble}}, uint, uint, Cdouble, Ptr{Ptr{Cdouble}}), p, n, ndim, kneg, gradU)
end

"""
    dss_calc_U_negdesign_nj(p, n, ndim, kneg, K_nj, pairs)


### Prototype
```c
double dss_calc_U_negdesign_nj(double **p, uint n, uint ndim, double kneg, double **K_nj, uint *pairs);
```
"""
function dss_calc_U_negdesign_nj(p, n, ndim, kneg, K_nj, pairs)
    ccall((:dss_calc_U_negdesign_nj, libdssopt), Cdouble, (Ptr{Ptr{Cdouble}}, uint, uint, Cdouble, Ptr{Ptr{Cdouble}}, Ptr{uint}), p, n, ndim, kneg, K_nj, pairs)
end

"""
    dss_calc_gradU_negdesign_nj(p, n, ndim, kneg, K_nj, pairs, gradU)


### Prototype
```c
void dss_calc_gradU_negdesign_nj(double **p, uint n, uint ndim, double kneg, double **K_nj, uint *pairs, double **gradU);
```
"""
function dss_calc_gradU_negdesign_nj(p, n, ndim, kneg, K_nj, pairs, gradU)
    ccall((:dss_calc_gradU_negdesign_nj, libdssopt), Cvoid, (Ptr{Ptr{Cdouble}}, uint, uint, Cdouble, Ptr{Ptr{Cdouble}}, Ptr{uint}, Ptr{Ptr{Cdouble}}), p, n, ndim, kneg, K_nj, pairs, gradU)
end

"""
    dss_calc_U_het(p, n, ndim, khet, het_window, pairs)


### Prototype
```c
double dss_calc_U_het(double **p, uint n, uint ndim, double khet, uint het_window, uint *pairs);
```
"""
function dss_calc_U_het(p, n, ndim, khet, het_window, pairs)
    ccall((:dss_calc_U_het, libdssopt), Cdouble, (Ptr{Ptr{Cdouble}}, uint, uint, Cdouble, uint, Ptr{uint}), p, n, ndim, khet, het_window, pairs)
end

"""
    dss_calc_gradU_het(p, n, ndim, khet, het_window, pairs, gradU)


### Prototype
```c
void dss_calc_gradU_het(double **p, uint n, uint ndim, double khet, uint het_window, uint *pairs, double **gradU);
```
"""
function dss_calc_gradU_het(p, n, ndim, khet, het_window, pairs, gradU)
    ccall((:dss_calc_gradU_het, libdssopt), Cvoid, (Ptr{Ptr{Cdouble}}, uint, uint, Cdouble, uint, Ptr{uint}, Ptr{Ptr{Cdouble}}), p, n, ndim, khet, het_window, pairs, gradU)
end

"""
    helper_make_K_nj_alloc(ndim)


### Prototype
```c
double **helper_make_K_nj_alloc(size_t ndim);
```
"""
function helper_make_K_nj_alloc(ndim)
    ccall((:helper_make_K_nj_alloc, libdssopt), Ptr{Ptr{Cdouble}}, (Csize_t,), ndim)
end

"""
    system_is_exploded(p, n1, n2)


### Prototype
```c
bool system_is_exploded(double **p, size_t n1, size_t n2);
```
"""
function system_is_exploded(p, n1, n2)
    ccall((:system_is_exploded, libdssopt), Bool, (Ptr{Ptr{Cdouble}}, Csize_t, Csize_t), p, n1, n2)
end

"""
    calc_entropy(p, n1, n2)


### Prototype
```c
double calc_entropy(double **p, size_t n1, size_t n2);
```
"""
function calc_entropy(p, n1, n2)
    ccall((:calc_entropy, libdssopt), Cdouble, (Ptr{Ptr{Cdouble}}, Csize_t, Csize_t), p, n1, n2)
end

"""
    is_bad_bp(seq, i, j)


### Prototype
```c
bool is_bad_bp(char *seq, uint i, uint j);
```
"""
function is_bad_bp(seq, i, j)
    ccall((:is_bad_bp, libdssopt), Bool, (Ptr{Cchar}, uint, uint), seq, i, j)
end

"""
    show_bad_bp(seq, pairs, n, verbose)


### Prototype
```c
void show_bad_bp(char *seq, uint *pairs, size_t n, bool verbose);
```
"""
function show_bad_bp(seq, pairs, n, verbose)
    ccall((:show_bad_bp, libdssopt), Cvoid, (Ptr{Cchar}, Ptr{uint}, Csize_t, Bool), seq, pairs, n, verbose)
end

"""
    fix_bad_bp(seq, pairs, n)


### Prototype
```c
size_t fix_bad_bp(char *seq, uint *pairs, size_t n);
```
"""
function fix_bad_bp(seq, pairs, n)
    ccall((:fix_bad_bp, libdssopt), Csize_t, (Ptr{Cchar}, Ptr{uint}, Csize_t), seq, pairs, n)
end

"""
    show_bad_prob(p, n1, n2, verbose)


### Prototype
```c
void show_bad_prob(double **p, size_t n1, size_t n2, bool verbose);
```
"""
function show_bad_prob(p, n1, n2, verbose)
    ccall((:show_bad_prob, libdssopt), Cvoid, (Ptr{Ptr{Cdouble}}, Csize_t, Csize_t, Bool), p, n1, n2, verbose)
end

"""
    print_for_movie(p, n, ndim, seq)


### Prototype
```c
void print_for_movie(double **p, size_t n, size_t ndim, char *seq);
```
"""
function print_for_movie(p, n, ndim, seq)
    ccall((:print_for_movie, libdssopt), Cvoid, (Ptr{Ptr{Cdouble}}, Csize_t, Csize_t, Ptr{Cchar}), p, n, ndim, seq)
end

"""
    x_ensure_positive(progname, optname, val)


### Prototype
```c
void x_ensure_positive(char *progname, char *optname, double val);
```
"""
function x_ensure_positive(progname, optname, val)
    ccall((:x_ensure_positive, libdssopt), Cvoid, (Ptr{Cchar}, Ptr{Cchar}, Cdouble), progname, optname, val)
end

"""
    set_dss_force_constants_defaults(kpi, kpa, kneg, kpur, khet, het_window)


### Prototype
```c
void set_dss_force_constants_defaults(double *kpi, double *kpa, double *kneg, double *kpur, double *khet, uint *het_window);
```
"""
function set_dss_force_constants_defaults(kpi, kpa, kneg, kpur, khet, het_window)
    ccall((:set_dss_force_constants_defaults, libdssopt), Cvoid, (Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{uint}), kpi, kpa, kneg, kpur, khet, het_window)
end

struct nn_stack
    i1::uint
    j1::uint
    i2::uint
    j2::uint
end

struct nn_hairpin
    i::uint
    j::uint
    size::uint
end

struct nn_bulge
    i1::uint
    j1::uint
    i2::uint
    j2::uint
    size::uint
end

struct nn_intloop
    i1::uint
    j1::uint
    i2::uint
    j2::uint
    size1::uint
    size2::uint
end

struct nn_multiloop
    unpaired::uint
    nstems::uint
    ndangle5::uint
    ndangle3::uint
    stems::Ptr{NTuple{2, uint}}
    dangle5::Ptr{NTuple{3, uint}}
    dangle3::Ptr{NTuple{3, uint}}
end

struct nn_inter
    n::uint
    nstack::uint
    nhairpin::uint
    nbulge::uint
    nintloop::uint
    nmultiloop::uint
    pairs::Ptr{uint}
    stack::Ptr{nn_stack}
    hairpin::Ptr{nn_hairpin}
    bulge::Ptr{nn_bulge}
    intloop::Ptr{nn_intloop}
    extloop::nn_multiloop
    multiloop::Ptr{nn_multiloop}
end

"""
    print_design_score_info_for_seq(inter, seq, n, ndim, K_nj, kpi, kpa, kpur, kneg, khet, het_window)


### Prototype
```c
void print_design_score_info_for_seq(struct nn_inter *inter, char *seq, uint n, uint ndim, double **K_nj, double kpi, double kpa, double kpur, double kneg, double khet, uint het_window);
```
"""
function print_design_score_info_for_seq(inter, seq, n, ndim, K_nj, kpi, kpa, kpur, kneg, khet, het_window)
    ccall((:print_design_score_info_for_seq, libdssopt), Cvoid, (Ptr{nn_inter}, Ptr{Cchar}, uint, uint, Ptr{Ptr{Cdouble}}, Cdouble, Cdouble, Cdouble, Cdouble, Cdouble, uint), inter, seq, n, ndim, K_nj, kpi, kpa, kpur, kneg, khet, het_window)
end

"""
    vienna_to_pairs(n, vienna, verbose, pairs)


### Prototype
```c
int vienna_to_pairs(uint n, const char *vienna, bool verbose, uint *pairs);
```
"""
function vienna_to_pairs(n, vienna, verbose, pairs)
    ccall((:vienna_to_pairs, libdssopt), Cint, (uint, Ptr{Cchar}, Bool, Ptr{uint}), n, vienna, verbose, pairs)
end

"""
    xvienna_to_pairs(n, vienna, pairs)


### Prototype
```c
void xvienna_to_pairs(uint n, const char *vienna, uint *pairs);
```
"""
function xvienna_to_pairs(n, vienna, pairs)
    ccall((:xvienna_to_pairs, libdssopt), Cvoid, (uint, Ptr{Cchar}, Ptr{uint}), n, vienna, pairs)
end

"""
    pairs_to_vienna(n, pairs, verbose, vienna)


### Prototype
```c
int pairs_to_vienna(uint n, const uint *pairs, bool verbose, char *vienna);
```
"""
function pairs_to_vienna(n, pairs, verbose, vienna)
    ccall((:pairs_to_vienna, libdssopt), Cint, (uint, Ptr{uint}, Bool, Ptr{Cchar}), n, pairs, verbose, vienna)
end

"""
    xpairs_to_vienna(n, pairs, vienna)


### Prototype
```c
char * xpairs_to_vienna(uint n, const uint *pairs, char *vienna);
```
"""
function xpairs_to_vienna(n, pairs, vienna)
    ccall((:xpairs_to_vienna, libdssopt), Ptr{Cchar}, (uint, Ptr{uint}, Ptr{Cchar}), n, pairs, vienna)
end

"""
    xstr_to_useq(n, str, useq)


### Prototype
```c
void xstr_to_useq(uint n, const char *str, uint *useq);
```
"""
function xstr_to_useq(n, str, useq)
    ccall((:xstr_to_useq, libdssopt), Cvoid, (uint, Ptr{Cchar}, Ptr{uint}), n, str, useq)
end

"""
    xstr_to_pseq(n, ndim, str, p)


### Prototype
```c
void xstr_to_pseq(uint n, uint ndim, const char *str, double **p);
```
"""
function xstr_to_pseq(n, ndim, str, p)
    ccall((:xstr_to_pseq, libdssopt), Cvoid, (uint, uint, Ptr{Cchar}, Ptr{Ptr{Cdouble}}), n, ndim, str, p)
end

"""
    pseq_to_str(p, n, ndim, str)


### Prototype
```c
void pseq_to_str(double **p, uint n, uint ndim, char *str);
```
"""
function pseq_to_str(p, n, ndim, str)
    ccall((:pseq_to_str, libdssopt), Cvoid, (Ptr{Ptr{Cdouble}}, uint, uint, Ptr{Cchar}), p, n, ndim, str)
end

"""
    xuseq_to_str(n, useq, str)


### Prototype
```c
void xuseq_to_str(uint n, const uint *useq, char *str);
```
"""
function xuseq_to_str(n, useq, str)
    ccall((:xuseq_to_str, libdssopt), Cvoid, (uint, Ptr{uint}, Ptr{Cchar}), n, useq, str)
end

"""
    useq_to_str(n, useq, verbose, str)


### Prototype
```c
int useq_to_str(uint n, const uint *useq, bool verbose, char *str);
```
"""
function useq_to_str(n, useq, verbose, str)
    ccall((:useq_to_str, libdssopt), Cint, (uint, Ptr{uint}, Bool, Ptr{Cchar}), n, useq, verbose, str)
end

"""
    nn_inter_xnew(n)


### Prototype
```c
struct nn_inter * nn_inter_xnew(uint n);
```
"""
function nn_inter_xnew(n)
    ccall((:nn_inter_xnew, libdssopt), Ptr{nn_inter}, (uint,), n)
end

"""
    nn_inter_delete(inter)


### Prototype
```c
void nn_inter_delete(struct nn_inter *inter);
```
"""
function nn_inter_delete(inter)
    ccall((:nn_inter_delete, libdssopt), Cvoid, (Ptr{nn_inter},), inter)
end

"""
    find_interactions(inter)


### Prototype
```c
void find_interactions(struct nn_inter *inter);
```
"""
function find_interactions(inter)
    ccall((:find_interactions, libdssopt), Cvoid, (Ptr{nn_inter},), inter)
end

"""
    print_interactions(inter)


### Prototype
```c
void print_interactions(const struct nn_inter *inter);
```
"""
function print_interactions(inter)
    ccall((:print_interactions, libdssopt), Cvoid, (Ptr{nn_inter},), inter)
end

"""
    random_pairs(n, pairs, hpmin)


### Prototype
```c
void random_pairs(uint n, uint *pairs, uint hpmin);
```
"""
function random_pairs(n, pairs, hpmin)
    ccall((:random_pairs, libdssopt), Cvoid, (uint, Ptr{uint}, uint), n, pairs, hpmin)
end

"""
    random_useq(n, pairs, useq)


### Prototype
```c
void random_useq(uint n, const uint *pairs, uint *useq);
```
"""
function random_useq(n, pairs, useq)
    ccall((:random_useq, libdssopt), Cvoid, (uint, Ptr{uint}, Ptr{uint}), n, pairs, useq)
end

"""
    calc_interactions(inter, useq)


### Prototype
```c
int calc_interactions(const struct nn_inter *inter, const uint *useq);
```
"""
function calc_interactions(inter, useq)
    ccall((:calc_interactions, libdssopt), Cint, (Ptr{nn_inter}, Ptr{uint}), inter, useq)
end

"""
    calc_interactions_pseq(inter, p)


### Prototype
```c
double calc_interactions_pseq(const struct nn_inter *inter, double **p);
```
"""
function calc_interactions_pseq(inter, p)
    ccall((:calc_interactions_pseq, libdssopt), Cdouble, (Ptr{nn_inter}, Ptr{Ptr{Cdouble}}), inter, p)
end

"""
    calc_interactions_dGdp_pseq(inter, p, dGdp)


### Prototype
```c
void calc_interactions_dGdp_pseq(const struct nn_inter *inter, double **p, double **dGdp);
```
"""
function calc_interactions_dGdp_pseq(inter, p, dGdp)
    ccall((:calc_interactions_dGdp_pseq, libdssopt), Cvoid, (Ptr{nn_inter}, Ptr{Ptr{Cdouble}}, Ptr{Ptr{Cdouble}}), inter, p, dGdp)
end

"""
    G_stack(seq, i1, j1, i2, j2)


### Prototype
```c
int G_stack(const uint *seq, uint i1, uint j1, uint i2, uint j2);
```
"""
function G_stack(seq, i1, j1, i2, j2)
    ccall((:G_stack, libdssopt), Cint, (Ptr{uint}, uint, uint, uint, uint), seq, i1, j1, i2, j2)
end

"""
    G_stack_pseq(p, i1, j1, i2, j2)


### Prototype
```c
double G_stack_pseq(double **p, uint i1, uint j1, uint i2, uint j2);
```
"""
function G_stack_pseq(p, i1, j1, i2, j2)
    ccall((:G_stack_pseq, libdssopt), Cdouble, (Ptr{Ptr{Cdouble}}, uint, uint, uint, uint), p, i1, j1, i2, j2)
end

"""
    dGdp_stack_pseq(p, i1, j1, i2, j2, dGdp)


### Prototype
```c
void dGdp_stack_pseq(double **p, uint i1, uint j1, uint i2, uint j2, double **dGdp);
```
"""
function dGdp_stack_pseq(p, i1, j1, i2, j2, dGdp)
    ccall((:dGdp_stack_pseq, libdssopt), Cvoid, (Ptr{Ptr{Cdouble}}, uint, uint, uint, uint, Ptr{Ptr{Cdouble}}), p, i1, j1, i2, j2, dGdp)
end

"""
    G_bulgeloop(seq, size, i1, j1, i2, j2)


### Prototype
```c
int G_bulgeloop(const uint *seq, uint size, uint i1, uint j1, uint i2, uint j2);
```
"""
function G_bulgeloop(seq, size, i1, j1, i2, j2)
    ccall((:G_bulgeloop, libdssopt), Cint, (Ptr{uint}, uint, uint, uint, uint, uint), seq, size, i1, j1, i2, j2)
end

"""
    G_bulgeloop_pseq(p, size, i1, j1, i2, j2)


### Prototype
```c
double G_bulgeloop_pseq(double **p, uint size, uint i1, uint j1, uint i2, uint j2);
```
"""
function G_bulgeloop_pseq(p, size, i1, j1, i2, j2)
    ccall((:G_bulgeloop_pseq, libdssopt), Cdouble, (Ptr{Ptr{Cdouble}}, uint, uint, uint, uint, uint), p, size, i1, j1, i2, j2)
end

"""
    dGdp_bulgeloop_pseq(p, size, i1, j1, i2, j2, dGdp)


### Prototype
```c
void dGdp_bulgeloop_pseq(double **p, uint size, uint i1, uint j1, uint i2, uint j2, double **dGdp);
```
"""
function dGdp_bulgeloop_pseq(p, size, i1, j1, i2, j2, dGdp)
    ccall((:dGdp_bulgeloop_pseq, libdssopt), Cvoid, (Ptr{Ptr{Cdouble}}, uint, uint, uint, uint, uint, Ptr{Ptr{Cdouble}}), p, size, i1, j1, i2, j2, dGdp)
end

"""
    G_intloop(seq, size1, size2, i1, j1, i2, j2)


### Prototype
```c
int G_intloop(const uint *seq, uint size1, uint size2, uint i1, uint j1, uint i2, uint j2);
```
"""
function G_intloop(seq, size1, size2, i1, j1, i2, j2)
    ccall((:G_intloop, libdssopt), Cint, (Ptr{uint}, uint, uint, uint, uint, uint, uint), seq, size1, size2, i1, j1, i2, j2)
end

"""
    G_intloop_pseq(p, size1, size2, i1, j1, i2, j2)


### Prototype
```c
double G_intloop_pseq(double **p, uint size1, uint size2, uint i1, uint j1, uint i2, uint j2);
```
"""
function G_intloop_pseq(p, size1, size2, i1, j1, i2, j2)
    ccall((:G_intloop_pseq, libdssopt), Cdouble, (Ptr{Ptr{Cdouble}}, uint, uint, uint, uint, uint, uint), p, size1, size2, i1, j1, i2, j2)
end

"""
    dGdp_intloop_pseq(p, size1, size2, i1, j1, i2, j2, dGdp)


### Prototype
```c
void dGdp_intloop_pseq(double **p, uint size1, uint size2, uint i1, uint j1, uint i2, uint j2, double **dGdp);
```
"""
function dGdp_intloop_pseq(p, size1, size2, i1, j1, i2, j2, dGdp)
    ccall((:dGdp_intloop_pseq, libdssopt), Cvoid, (Ptr{Ptr{Cdouble}}, uint, uint, uint, uint, uint, uint, Ptr{Ptr{Cdouble}}), p, size1, size2, i1, j1, i2, j2, dGdp)
end

"""
    G_hairpin(seq, size, i1, j1)


### Prototype
```c
int G_hairpin(const uint *seq, uint size, uint i1, uint j1);
```
"""
function G_hairpin(seq, size, i1, j1)
    ccall((:G_hairpin, libdssopt), Cint, (Ptr{uint}, uint, uint, uint), seq, size, i1, j1)
end

"""
    G_hairpin_pseq(p, size, i1, j1)


### Prototype
```c
double G_hairpin_pseq(double **p, uint size, uint i1, uint j1);
```
"""
function G_hairpin_pseq(p, size, i1, j1)
    ccall((:G_hairpin_pseq, libdssopt), Cdouble, (Ptr{Ptr{Cdouble}}, uint, uint, uint), p, size, i1, j1)
end

"""
    dGdp_hairpin_pseq(p, size, i1, j1, dGdp)


### Prototype
```c
void dGdp_hairpin_pseq(double **p, uint size, uint i1, uint j1, double **dGdp);
```
"""
function dGdp_hairpin_pseq(p, size, i1, j1, dGdp)
    ccall((:dGdp_hairpin_pseq, libdssopt), Cvoid, (Ptr{Ptr{Cdouble}}, uint, uint, uint, Ptr{Ptr{Cdouble}}), p, size, i1, j1, dGdp)
end

"""
    G_extloop_multiloop(seq, unpaired, nstems, stems, ndangle5, dangle5, ndangle3, dangle3, is_multiloop)


### Prototype
```c
int G_extloop_multiloop(const uint *seq, uint unpaired, uint nstems, uint (*stems)[2], uint ndangle5, uint (*dangle5)[3], uint ndangle3, uint (*dangle3)[3], bool is_multiloop);
```
"""
function G_extloop_multiloop(seq, unpaired, nstems, stems, ndangle5, dangle5, ndangle3, dangle3, is_multiloop)
    ccall((:G_extloop_multiloop, libdssopt), Cint, (Ptr{uint}, uint, uint, Ptr{NTuple{2, uint}}, uint, Ptr{NTuple{3, uint}}, uint, Ptr{NTuple{3, uint}}, Bool), seq, unpaired, nstems, stems, ndangle5, dangle5, ndangle3, dangle3, is_multiloop)
end

"""
    G_extloop_multiloop_pseq(p, unpaired, nstems, stems, ndangle5, dangle5, ndangle3, dangle3, is_multiloop)


### Prototype
```c
double G_extloop_multiloop_pseq(double **p, uint unpaired, uint nstems, uint (*stems)[2], uint ndangle5, uint (*dangle5)[3], uint ndangle3, uint (*dangle3)[3], bool is_multiloop);
```
"""
function G_extloop_multiloop_pseq(p, unpaired, nstems, stems, ndangle5, dangle5, ndangle3, dangle3, is_multiloop)
    ccall((:G_extloop_multiloop_pseq, libdssopt), Cdouble, (Ptr{Ptr{Cdouble}}, uint, uint, Ptr{NTuple{2, uint}}, uint, Ptr{NTuple{3, uint}}, uint, Ptr{NTuple{3, uint}}, Bool), p, unpaired, nstems, stems, ndangle5, dangle5, ndangle3, dangle3, is_multiloop)
end

"""
    dGdp_extloop_multiloop_pseq(p, nstems, stems, ndangle5, dangle5, ndangle3, dangle3, dGdp)


### Prototype
```c
void dGdp_extloop_multiloop_pseq(double **p, uint nstems, uint (*stems)[2], uint ndangle5, uint (*dangle5)[3], uint ndangle3, uint (*dangle3)[3], double **dGdp);
```
"""
function dGdp_extloop_multiloop_pseq(p, nstems, stems, ndangle5, dangle5, ndangle3, dangle3, dGdp)
    ccall((:dGdp_extloop_multiloop_pseq, libdssopt), Cvoid, (Ptr{Ptr{Cdouble}}, uint, Ptr{NTuple{2, uint}}, uint, Ptr{NTuple{3, uint}}, uint, Ptr{NTuple{3, uint}}, Ptr{Ptr{Cdouble}}), p, nstems, stems, ndangle5, dangle5, ndangle3, dangle3, dGdp)
end

"""
    md_calc_temperature(n, ndim, v, mass, kb, ndof)


### Prototype
```c
double md_calc_temperature(uint n, uint ndim, double **v, double *mass, double kb, double ndof);
```
"""
function md_calc_temperature(n, ndim, v, mass, kb, ndof)
    ccall((:md_calc_temperature, libdssopt), Cdouble, (uint, uint, Ptr{Ptr{Cdouble}}, Ptr{Cdouble}, Cdouble, Cdouble), n, ndim, v, mass, kb, ndof)
end

"""
    md_init_velocities_random(n, ndim, v, mass, kb, ndf, T)


### Prototype
```c
void md_init_velocities_random(uint n, uint ndim, double **v, double *mass, double kb, double ndf, double T);
```
"""
function md_init_velocities_random(n, ndim, v, mass, kb, ndf, T)
    ccall((:md_init_velocities_random, libdssopt), Cvoid, (uint, uint, Ptr{Ptr{Cdouble}}, Ptr{Cdouble}, Cdouble, Cdouble, Cdouble), n, ndim, v, mass, kb, ndf, T)
end

"""
    md_init_velocities_maxwell_boltzmann(n, ndim, v, mass, kb, ndof, T)


### Prototype
```c
void md_init_velocities_maxwell_boltzmann(uint n, uint ndim, double **v, double *mass, double kb, double ndof, double T);
```
"""
function md_init_velocities_maxwell_boltzmann(n, ndim, v, mass, kb, ndof, T)
    ccall((:md_init_velocities_maxwell_boltzmann, libdssopt), Cvoid, (uint, uint, Ptr{Ptr{Cdouble}}, Ptr{Cdouble}, Cdouble, Cdouble, Cdouble), n, ndim, v, mass, kb, ndof, T)
end

"""
    md_remove_net_momentum_no_rescale(n, ndim, v, mass)


### Prototype
```c
void md_remove_net_momentum_no_rescale(uint n, uint ndim, double **v, double *mass);
```
"""
function md_remove_net_momentum_no_rescale(n, ndim, v, mass)
    ccall((:md_remove_net_momentum_no_rescale, libdssopt), Cvoid, (uint, uint, Ptr{Ptr{Cdouble}}, Ptr{Cdouble}), n, ndim, v, mass)
end

"""
    md_rescale_temperature(n, ndim, v, mass, kb, ndf, T_desired)


### Prototype
```c
void md_rescale_temperature(uint n, uint ndim, double **v, double *mass, double kb, double ndf, double T_desired);
```
"""
function md_rescale_temperature(n, ndim, v, mass, kb, ndf, T_desired)
    ccall((:md_rescale_temperature, libdssopt), Cvoid, (uint, uint, Ptr{Ptr{Cdouble}}, Ptr{Cdouble}, Cdouble, Cdouble, Cdouble), n, ndim, v, mass, kb, ndf, T_desired)
end

"""
    md_rescale_temperature_berendsen(n, ndim, v, mass, kb, ndof, T_desired, timestep, tau)


### Prototype
```c
void md_rescale_temperature_berendsen(uint n, uint ndim, double **v, double *mass, double kb, double ndof, double T_desired, double timestep, double tau);
```
"""
function md_rescale_temperature_berendsen(n, ndim, v, mass, kb, ndof, T_desired, timestep, tau)
    ccall((:md_rescale_temperature_berendsen, libdssopt), Cvoid, (uint, uint, Ptr{Ptr{Cdouble}}, Ptr{Cdouble}, Cdouble, Cdouble, Cdouble, Cdouble, Cdouble), n, ndim, v, mass, kb, ndof, T_desired, timestep, tau)
end

"""
    md_integrate_step_leapfrog(n, ndim, r, v, gradU, mass, timestep)


### Prototype
```c
void md_integrate_step_leapfrog(uint n, uint ndim, double **r, double **v, double **gradU, double *mass, double timestep);
```
"""
function md_integrate_step_leapfrog(n, ndim, r, v, gradU, mass, timestep)
    ccall((:md_integrate_step_leapfrog, libdssopt), Cvoid, (uint, uint, Ptr{Ptr{Cdouble}}, Ptr{Ptr{Cdouble}}, Ptr{Ptr{Cdouble}}, Ptr{Cdouble}, Cdouble), n, ndim, r, v, gradU, mass, timestep)
end

const DEFAULT_DSSOPT_ndim = Cuint(4)

const DEFAULT_DSSOPT_kpi = 50000.0

const DEFAULT_DSSOPT_kpa = 50000.0

const DEFAULT_DSSOPT_kneg = 1.0

const DEFAULT_DSSOPT_kpur = 0.0

const DEFAULT_DSSOPT_khet = 10.0

const DEFAULT_DSSOPT_het_window = Cuint(3)

const NA_UNDEF = UINT_MAX ÷ 2

const NA_UNPAIRED = UINT_MAX ÷ 2

const NA_BASE_N = UINT_MAX ÷ 2

const NA_BASE_A = uint(0)

const NA_BASE_C = uint(1)

const NA_BASE_G = uint(2)

const NA_BASE_U = uint(3)

const NN_INF = 1000000

const NN_LXC37 = 107.856

const NN_N_HAIRPINLOOP = 31

const NN_N_BULGELOOP = 31

const NN_N_INTERNALLOOP = 31

const NN_ML_OFFSET = 340

const NN_ML_UNPAIRED = 0

const NN_ML_STEMS = 40

const NN_G_NON_GC_PENALTY = 50

const NN_NINIO_M = 50

const NN_NINIO_MAX = 300

const NN_NTETRALOOP = 30

end # module
