module load gemma/0.94

gemma -g Hsgtype2 -p Birthrate -k Men2relatedness -lmm 1 -o Familysize_hs
gemma -g Hsgtype2 -p Birthrate -k Men2relatedness -lmm 1 -c Cov_ -o Birthrate_hs_3C
gemma -g Hsgtype2 -p Birthrate -k Men2relatedness_2 -lmm 1 -o Familysize_hs
gemma -g Hsgtype2 -p Birthrate -k Men2relatedness_2 -lmm 1 -o Birthrate_hs
gemma -g Hsgtype2 -p Birthrate -k Men2relatedness_2 -lmm 1 -c Cov2_3 -o Birthrate_hs_3C
gemma -g Hsgtype2 -p Birthrate -k Men2relatedness_2 -lmm 1 -c Cov2_4wfgtype -o Birthrate_hs_4C
gemma -g Wfgtype2 -p Birthrate -k Women2relatedness_2 -lmm 1 -o _wf
gemma -g Wfgtype2 -p Birthrate -k Women2relatedness_2 -lmm 1 -c Cov2_3 -o Birthrate_wf_3C
gemma -g Wfgtype2 -p Birthrate -k Women2relatedness_2 -lmm 1 -c Cov2_4hsgtype -o Birthrate_wf_4C
gemma -g Hsgtype1 -p Familysize -k Men1relatedness_2  -lmm 1 -o Familysize_hs
gemma -g Hsgtype1 -p Familysize -k Men1relatedness_2  -lmm 1 -c Cov1_3 -o Familysize_hs_3
gemma -g Hsgtype1 -p Familysize -k Men1relatedness_2  -lmm 1 -c Cov1_3 -o Familysize_hs_3C
gemma -g Hsgtype1 -p Familysize -k Men1relatedness_2  -lmm 1 -c Cov1_4wfgtype -o Familysize_hs_4C
gemma -g Wfgtype1 -p Familysize -k Women1relatedness_2  -lmm 1 -o Familysize_wf
gemma -g Wfgtype1 -p Familysize -k Women1relatedness_2  -lmm 1 -c Cov1_3 -o Familysize_wf_3C
gemma -g Wfgtype1 -p Familysize -k Women1relatedness_2  -lmm 1 -c Cov1_4hsgtype -o Familysize_wf_4C
gemma -g Hsgtype1 -p Familysize -k Men1relatedness  -lmm 1 -c Cov1_3 -o Familysize_hs_3_test


gemma -g Hsgtype2 -p Birthrate -k Men2relatedness_2 -lmm 3 -c Cov2_5wfgtype -o Birthrate_hs_5C
gemma -g Hsgtype2 -p Birthrate -k Men2relatedness_2 -lmm 3 -c Cov2_5wfgtype -o Birthrate_hs_5C
gemma -g Wfgtype0 -p Familysize0 -k Women0relatedness_2 -lmm 3 -c Cov0_5hsgtype -o Familysize_wf_5C
gemma -g Hsgtype2 -p Birthrate -k Men2relatedness_2 -lmm 1 -c Cov2_5wfgtype -o Birthrate_hs_5C_lmm1
gemma -g Wfgtype0 -p Familysize0 -k Women0relatedness_2 -lmm 1 -c Cov0_5hsgtype -o Familysize_wf_5C_lmm1
gemma -g Wfgtype0 -p Familysize0 -k Women0relatedness_2 -lmm 2 -c Cov0_5hsgtype -o Familysize_wf_5C_lmm2
gemma -g Hsgtype2 -p Birthrate -k Men2relatedness_2 -lmm 2 -c Cov2_5wfgtype -o Birthrate_hs_5C_lmm2
gemma -g Wfgtype2 -p Birthrate -k Women2relatedness_2 -lmm 2 -c Cov2_5hsgtype -o Birthrate_wf_5C_lmm2
gemma -g Hsgtype1 -p Familysize -k Men1relatedness_2 -lmm 2 -c Cov1_5wfgtype -o Familysize1_hs_5C_lmm2
gemma -g Hsgtype1 -p Familysize -k Men1relatedness_2 -lmm 1 -c Cov1_5wfgtype -o Familysize1_hs_5C_lmm1
gemma -g Wfgtype2 -p Birthrate -k Women2relatedness_2 -lmm 1 -c Cov2_5hsgtype -o Birthrate_wf_5C_lmm1
gemma -g Wfgtype1 -p Familysize -k Women1relatedness_2 -lmm 1 -c Cov1_5hsgtype -o Familysize1_wf_5C_lmm1
gemma -g Wfgtype0 -p Familysize0 -k Women0relatedness_2 -lmm 1 -c Cov0_5hsgtype -o Familysize0_wf_5C_lmm1
gemma -g Hsgtype0 -p Familysize0 -k Men0relatedness_2 -lmm 1 -c Cov0_5wfgtype -o Familysize0_hs_5C_lmm1
gemma -g Hsgtype0 -p Familysize0 -k Men0relatedness_2 -lmm 1 -c Cov0_5wfgtype -o Familysize0_hs_5C_lmm1
gemma -g Hsgtype0 -p Familysize0 -k Men0relatedness_2 -lmm 1 -c Cov0_5wfgtype -o Familysize0_hs_5C_lmm1
gemma -g Hsgtype0 -p Familysize0 -k Men0relatedness_2 -lmm 1 -c Cov0_5wfgtype -o Familysize0_hs_5C_lmm1
gemma -g Wfgtype0 -p Familysize0 -k Women0relatedness_2 -lmm 1 -c Cov0_5hsgtype -o Familysize0_wf_5C_lmm1
gemma -g Hsgtype0 -p Familysize0 -k Men0relatedness_2 -lmm 1 -c Cov0_5wfgtype -o Familysize0_hs_5C_lmm1
