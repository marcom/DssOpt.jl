module LibDssOpt

using DssOpt_jll
export DssOpt_jll

using CEnum

#### begin prologue.jl

const UINT_MAX = typemax(Cuint)

#### end prologue.jl


function dary_set(a, n, val)
    ccall((:dary_set, libdssopt), Cvoid, (Ptr{Cdouble}, Csize_t, Cdouble), a, n, val)
end

function dary_equal(a, b, n)
    ccall((:dary_equal, libdssopt), Bool, (Ptr{Cdouble}, Ptr{Cdouble}, Csize_t), a, b, n)
end

function dary_print(a, n)
    ccall((:dary_print, libdssopt), Cvoid, (Ptr{Cdouble}, Csize_t), a, n)
end

function dary_is_finite(a, n)
    ccall((:dary_is_finite, libdssopt), Bool, (Ptr{Cdouble}, Csize_t), a, n)
end

function dary2d_set(n1, n2, a, val)
    ccall((:dary2d_set, libdssopt), Cvoid, (Csize_t, Csize_t, Ptr{Ptr{Cdouble}}, Cdouble), n1, n2, a, val)
end

function dary2d_equal(a, b, n1, n2)
    ccall((:dary2d_equal, libdssopt), Bool, (Ptr{Ptr{Cdouble}}, Ptr{Ptr{Cdouble}}, Csize_t, Csize_t), a, b, n1, n2)
end

function dary2d_print(a, n1, n2)
    ccall((:dary2d_print, libdssopt), Cvoid, (Ptr{Ptr{Cdouble}}, Csize_t, Csize_t), a, n1, n2)
end

function dary2d_is_finite(a, n1, n2)
    ccall((:dary2d_is_finite, libdssopt), Bool, (Ptr{Ptr{Cdouble}}, Csize_t, Csize_t), a, n1, n2)
end

function xmalloc(size)
    ccall((:xmalloc, libdssopt), Ptr{Cvoid}, (Csize_t,), size)
end

const uchar = Cuchar

const uint = Cuint

const ulong = Culong

function plogp_sane(p)
    ccall((:plogp_sane, libdssopt), Cdouble, (Cdouble,), p)
end

function random_seed(seed)
    ccall((:random_seed, libdssopt), Cvoid, (uint,), seed)
end

function random_get_seedval_from_current_time()
    ccall((:random_get_seedval_from_current_time, libdssopt), uint, ())
end

function random_seed_with_current_time()
    ccall((:random_seed_with_current_time, libdssopt), Cvoid, ())
end

function random_uint(a, b)
    ccall((:random_uint, libdssopt), uint, (uint, uint), a, b)
end

function random_double_uniform()
    ccall((:random_double_uniform, libdssopt), Cdouble, ())
end

function random_double_normal(mu, sigma)
    ccall((:random_double_normal, libdssopt), Cdouble, (Cdouble, Cdouble), mu, sigma)
end

function random_dvec_uniform_direction(ndim, v)
    ccall((:random_dvec_uniform_direction, libdssopt), Cvoid, (uint, Ptr{Cdouble}), ndim, v)
end

function dss_calc_U_pa(p, n, ndim, k)
    ccall((:dss_calc_U_pa, libdssopt), Cdouble, (Ptr{Ptr{Cdouble}}, uint, uint, Cdouble), p, n, ndim, k)
end

function dss_calc_gradU_pa(p, n, ndim, k, gradU)
    ccall((:dss_calc_gradU_pa, libdssopt), Cvoid, (Ptr{Ptr{Cdouble}}, uint, uint, Cdouble, Ptr{Ptr{Cdouble}}), p, n, ndim, k, gradU)
end

function dss_calc_U_pi(p, n, ndim, k)
    ccall((:dss_calc_U_pi, libdssopt), Cdouble, (Ptr{Ptr{Cdouble}}, uint, uint, Cdouble), p, n, ndim, k)
end

function dss_calc_gradU_pi(p, n, ndim, k, gradU)
    ccall((:dss_calc_gradU_pi, libdssopt), Cvoid, (Ptr{Ptr{Cdouble}}, uint, uint, Cdouble, Ptr{Ptr{Cdouble}}), p, n, ndim, k, gradU)
end

function dss_calc_U_pur_cauchy(p, n, ndim, kpur)
    ccall((:dss_calc_U_pur_cauchy, libdssopt), Cdouble, (Ptr{Ptr{Cdouble}}, uint, uint, Cdouble), p, n, ndim, kpur)
end

function dss_calc_gradU_pur_cauchy(p, n, ndim, kpur, gradU)
    ccall((:dss_calc_gradU_pur_cauchy, libdssopt), Cvoid, (Ptr{Ptr{Cdouble}}, uint, uint, Cdouble, Ptr{Ptr{Cdouble}}), p, n, ndim, kpur, gradU)
end

function dss_calc_U_negdesign_het(p, n, ndim, kneg)
    ccall((:dss_calc_U_negdesign_het, libdssopt), Cdouble, (Ptr{Ptr{Cdouble}}, uint, uint, Cdouble), p, n, ndim, kneg)
end

function dss_calc_gradU_negdesign_het(p, n, ndim, kneg, gradU)
    ccall((:dss_calc_gradU_negdesign_het, libdssopt), Cvoid, (Ptr{Ptr{Cdouble}}, uint, uint, Cdouble, Ptr{Ptr{Cdouble}}), p, n, ndim, kneg, gradU)
end

function dss_calc_U_negdesign_nj(p, n, ndim, kneg, K_nj, pairs)
    ccall((:dss_calc_U_negdesign_nj, libdssopt), Cdouble, (Ptr{Ptr{Cdouble}}, uint, uint, Cdouble, Ptr{Ptr{Cdouble}}, Ptr{uint}), p, n, ndim, kneg, K_nj, pairs)
end

function dss_calc_gradU_negdesign_nj(p, n, ndim, kneg, K_nj, pairs, gradU)
    ccall((:dss_calc_gradU_negdesign_nj, libdssopt), Cvoid, (Ptr{Ptr{Cdouble}}, uint, uint, Cdouble, Ptr{Ptr{Cdouble}}, Ptr{uint}, Ptr{Ptr{Cdouble}}), p, n, ndim, kneg, K_nj, pairs, gradU)
end

function dss_calc_U_het(p, n, ndim, khet, het_window, pairs)
    ccall((:dss_calc_U_het, libdssopt), Cdouble, (Ptr{Ptr{Cdouble}}, uint, uint, Cdouble, uint, Ptr{uint}), p, n, ndim, khet, het_window, pairs)
end

function dss_calc_gradU_het(p, n, ndim, khet, het_window, pairs, gradU)
    ccall((:dss_calc_gradU_het, libdssopt), Cvoid, (Ptr{Ptr{Cdouble}}, uint, uint, Cdouble, uint, Ptr{uint}, Ptr{Ptr{Cdouble}}), p, n, ndim, khet, het_window, pairs, gradU)
end

function helper_make_K_nj_alloc(ndim)
    ccall((:helper_make_K_nj_alloc, libdssopt), Ptr{Ptr{Cdouble}}, (Csize_t,), ndim)
end

function system_is_exploded(p, n1, n2)
    ccall((:system_is_exploded, libdssopt), Bool, (Ptr{Ptr{Cdouble}}, Csize_t, Csize_t), p, n1, n2)
end

function calc_entropy(p, n1, n2)
    ccall((:calc_entropy, libdssopt), Cdouble, (Ptr{Ptr{Cdouble}}, Csize_t, Csize_t), p, n1, n2)
end

function is_bad_bp(seq, i, j)
    ccall((:is_bad_bp, libdssopt), Bool, (Ptr{Cchar}, uint, uint), seq, i, j)
end

function show_bad_bp(seq, pairs, n)
    ccall((:show_bad_bp, libdssopt), Cvoid, (Ptr{Cchar}, Ptr{uint}, Csize_t), seq, pairs, n)
end

function fix_bad_bp(seq, pairs, n)
    ccall((:fix_bad_bp, libdssopt), Csize_t, (Ptr{Cchar}, Ptr{uint}, Csize_t), seq, pairs, n)
end

function show_bad_prob(p, n1, n2)
    ccall((:show_bad_prob, libdssopt), Cvoid, (Ptr{Ptr{Cdouble}}, Csize_t, Csize_t), p, n1, n2)
end

function print_for_movie(p, n, ndim, seq)
    ccall((:print_for_movie, libdssopt), Cvoid, (Ptr{Ptr{Cdouble}}, Csize_t, Csize_t, Ptr{Cchar}), p, n, ndim, seq)
end

function x_ensure_positive(progname, optname, val)
    ccall((:x_ensure_positive, libdssopt), Cvoid, (Ptr{Cchar}, Ptr{Cchar}, Cdouble), progname, optname, val)
end

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

function print_design_score_info_for_seq(inter, seq, n, ndim, K_nj, kpi, kpa, kpur, kneg, khet, het_window)
    ccall((:print_design_score_info_for_seq, libdssopt), Cvoid, (Ptr{nn_inter}, Ptr{Cchar}, uint, uint, Ptr{Ptr{Cdouble}}, Cdouble, Cdouble, Cdouble, Cdouble, Cdouble, uint), inter, seq, n, ndim, K_nj, kpi, kpa, kpur, kneg, khet, het_window)
end

function xvienna_to_pairs(n, vienna, pairs)
    ccall((:xvienna_to_pairs, libdssopt), Cvoid, (uint, Ptr{Cchar}, Ptr{uint}), n, vienna, pairs)
end

function xpairs_to_vienna(n, pairs, vienna)
    ccall((:xpairs_to_vienna, libdssopt), Ptr{Cchar}, (uint, Ptr{uint}, Ptr{Cchar}), n, pairs, vienna)
end

function xstr_to_seq(n, str, seq)
    ccall((:xstr_to_seq, libdssopt), Cvoid, (uint, Ptr{Cchar}, Ptr{uint}), n, str, seq)
end

function xstr_to_pseq(n, ndim, str, p)
    ccall((:xstr_to_pseq, libdssopt), Cvoid, (uint, uint, Ptr{Cchar}, Ptr{Ptr{Cdouble}}), n, ndim, str, p)
end

function pseq_to_str(p, n, ndim, str)
    ccall((:pseq_to_str, libdssopt), Cvoid, (Ptr{Ptr{Cdouble}}, uint, uint, Ptr{Cchar}), p, n, ndim, str)
end

function nn_inter_xnew(n)
    ccall((:nn_inter_xnew, libdssopt), Ptr{nn_inter}, (uint,), n)
end

function nn_inter_delete(inter)
    ccall((:nn_inter_delete, libdssopt), Cvoid, (Ptr{nn_inter},), inter)
end

function find_interactions(inter)
    ccall((:find_interactions, libdssopt), Cvoid, (Ptr{nn_inter},), inter)
end

function print_interactions(inter)
    ccall((:print_interactions, libdssopt), Cvoid, (Ptr{nn_inter},), inter)
end

function random_pairs(n, pairs, hpmin)
    ccall((:random_pairs, libdssopt), Cvoid, (uint, Ptr{uint}, uint), n, pairs, hpmin)
end

function random_seq(n, pairs, seq)
    ccall((:random_seq, libdssopt), Cvoid, (uint, Ptr{uint}, Ptr{uint}), n, pairs, seq)
end

function calc_interactions(inter, useq)
    ccall((:calc_interactions, libdssopt), Cint, (Ptr{nn_inter}, Ptr{uint}), inter, useq)
end

function calc_interactions_pseq(inter, p)
    ccall((:calc_interactions_pseq, libdssopt), Cdouble, (Ptr{nn_inter}, Ptr{Ptr{Cdouble}}), inter, p)
end

function calc_interactions_dGdp_pseq(inter, p, dGdp)
    ccall((:calc_interactions_dGdp_pseq, libdssopt), Cvoid, (Ptr{nn_inter}, Ptr{Ptr{Cdouble}}, Ptr{Ptr{Cdouble}}), inter, p, dGdp)
end

function G_stack(seq, i1, j1, i2, j2)
    ccall((:G_stack, libdssopt), Cint, (Ptr{uint}, uint, uint, uint, uint), seq, i1, j1, i2, j2)
end

function G_stack_pseq(p, i1, j1, i2, j2)
    ccall((:G_stack_pseq, libdssopt), Cdouble, (Ptr{Ptr{Cdouble}}, uint, uint, uint, uint), p, i1, j1, i2, j2)
end

function dGdp_stack_pseq(p, i1, j1, i2, j2, dGdp)
    ccall((:dGdp_stack_pseq, libdssopt), Cvoid, (Ptr{Ptr{Cdouble}}, uint, uint, uint, uint, Ptr{Ptr{Cdouble}}), p, i1, j1, i2, j2, dGdp)
end

function G_bulgeloop(seq, size, i1, j1, i2, j2)
    ccall((:G_bulgeloop, libdssopt), Cint, (Ptr{uint}, uint, uint, uint, uint, uint), seq, size, i1, j1, i2, j2)
end

function G_bulgeloop_pseq(p, size, i1, j1, i2, j2)
    ccall((:G_bulgeloop_pseq, libdssopt), Cdouble, (Ptr{Ptr{Cdouble}}, uint, uint, uint, uint, uint), p, size, i1, j1, i2, j2)
end

function dGdp_bulgeloop_pseq(p, size, i1, j1, i2, j2, dGdp)
    ccall((:dGdp_bulgeloop_pseq, libdssopt), Cvoid, (Ptr{Ptr{Cdouble}}, uint, uint, uint, uint, uint, Ptr{Ptr{Cdouble}}), p, size, i1, j1, i2, j2, dGdp)
end

function G_intloop(seq, size1, size2, i1, j1, i2, j2)
    ccall((:G_intloop, libdssopt), Cint, (Ptr{uint}, uint, uint, uint, uint, uint, uint), seq, size1, size2, i1, j1, i2, j2)
end

function G_intloop_pseq(p, size1, size2, i1, j1, i2, j2)
    ccall((:G_intloop_pseq, libdssopt), Cdouble, (Ptr{Ptr{Cdouble}}, uint, uint, uint, uint, uint, uint), p, size1, size2, i1, j1, i2, j2)
end

function dGdp_intloop_pseq(p, size1, size2, i1, j1, i2, j2, dGdp)
    ccall((:dGdp_intloop_pseq, libdssopt), Cvoid, (Ptr{Ptr{Cdouble}}, uint, uint, uint, uint, uint, uint, Ptr{Ptr{Cdouble}}), p, size1, size2, i1, j1, i2, j2, dGdp)
end

function G_hairpin(seq, size, i1, j1)
    ccall((:G_hairpin, libdssopt), Cint, (Ptr{uint}, uint, uint, uint), seq, size, i1, j1)
end

function G_hairpin_pseq(p, size, i1, j1)
    ccall((:G_hairpin_pseq, libdssopt), Cdouble, (Ptr{Ptr{Cdouble}}, uint, uint, uint), p, size, i1, j1)
end

function dGdp_hairpin_pseq(p, size, i1, j1, dGdp)
    ccall((:dGdp_hairpin_pseq, libdssopt), Cvoid, (Ptr{Ptr{Cdouble}}, uint, uint, uint, Ptr{Ptr{Cdouble}}), p, size, i1, j1, dGdp)
end

function G_extloop_multiloop(seq, unpaired, nstems, stems, ndangle5, dangle5, ndangle3, dangle3, is_multiloop)
    ccall((:G_extloop_multiloop, libdssopt), Cint, (Ptr{uint}, uint, uint, Ptr{NTuple{2, uint}}, uint, Ptr{NTuple{3, uint}}, uint, Ptr{NTuple{3, uint}}, Bool), seq, unpaired, nstems, stems, ndangle5, dangle5, ndangle3, dangle3, is_multiloop)
end

function G_extloop_multiloop_pseq(p, unpaired, nstems, stems, ndangle5, dangle5, ndangle3, dangle3, is_multiloop)
    ccall((:G_extloop_multiloop_pseq, libdssopt), Cdouble, (Ptr{Ptr{Cdouble}}, uint, uint, Ptr{NTuple{2, uint}}, uint, Ptr{NTuple{3, uint}}, uint, Ptr{NTuple{3, uint}}, Bool), p, unpaired, nstems, stems, ndangle5, dangle5, ndangle3, dangle3, is_multiloop)
end

function dGdp_extloop_multiloop_pseq(p, nstems, stems, ndangle5, dangle5, ndangle3, dangle3, dGdp)
    ccall((:dGdp_extloop_multiloop_pseq, libdssopt), Cvoid, (Ptr{Ptr{Cdouble}}, uint, Ptr{NTuple{2, uint}}, uint, Ptr{NTuple{3, uint}}, uint, Ptr{NTuple{3, uint}}, Ptr{Ptr{Cdouble}}), p, nstems, stems, ndangle5, dangle5, ndangle3, dangle3, dGdp)
end

function md_calc_temperature(n, ndim, v, mass, kb, ndof)
    ccall((:md_calc_temperature, libdssopt), Cdouble, (uint, uint, Ptr{Ptr{Cdouble}}, Ptr{Cdouble}, Cdouble, Cdouble), n, ndim, v, mass, kb, ndof)
end

function md_init_velocities_random(n, ndim, v, mass, kb, ndf, T)
    ccall((:md_init_velocities_random, libdssopt), Cvoid, (uint, uint, Ptr{Ptr{Cdouble}}, Ptr{Cdouble}, Cdouble, Cdouble, Cdouble), n, ndim, v, mass, kb, ndf, T)
end

function md_init_velocities_maxwell_boltzmann(n, ndim, v, mass, kb, ndof, T)
    ccall((:md_init_velocities_maxwell_boltzmann, libdssopt), Cvoid, (uint, uint, Ptr{Ptr{Cdouble}}, Ptr{Cdouble}, Cdouble, Cdouble, Cdouble), n, ndim, v, mass, kb, ndof, T)
end

function md_remove_net_momentum_no_rescale(n, ndim, v, mass)
    ccall((:md_remove_net_momentum_no_rescale, libdssopt), Cvoid, (uint, uint, Ptr{Ptr{Cdouble}}, Ptr{Cdouble}), n, ndim, v, mass)
end

function md_rescale_temperature(n, ndim, v, mass, kb, ndf, T_desired)
    ccall((:md_rescale_temperature, libdssopt), Cvoid, (uint, uint, Ptr{Ptr{Cdouble}}, Ptr{Cdouble}, Cdouble, Cdouble, Cdouble), n, ndim, v, mass, kb, ndf, T_desired)
end

function md_rescale_temperature_berendsen(n, ndim, v, mass, kb, ndof, T_desired, timestep, tau)
    ccall((:md_rescale_temperature_berendsen, libdssopt), Cvoid, (uint, uint, Ptr{Ptr{Cdouble}}, Ptr{Cdouble}, Cdouble, Cdouble, Cdouble, Cdouble, Cdouble), n, ndim, v, mass, kb, ndof, T_desired, timestep, tau)
end

function md_integrate_step_leapfrog(n, ndim, r, v, gradU, mass, timestep)
    ccall((:md_integrate_step_leapfrog, libdssopt), Cvoid, (uint, uint, Ptr{Ptr{Cdouble}}, Ptr{Ptr{Cdouble}}, Ptr{Ptr{Cdouble}}, Ptr{Cdouble}, Cdouble), n, ndim, r, v, gradU, mass, timestep)
end

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
