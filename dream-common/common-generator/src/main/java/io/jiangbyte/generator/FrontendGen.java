package io.jiangbyte.generator;

import com.baomidou.mybatisplus.generator.FastAutoGenerator;
import com.baomidou.mybatisplus.generator.config.DataSourceConfig;
import com.baomidou.mybatisplus.generator.config.builder.CustomFile;
import com.baomidou.mybatisplus.generator.config.po.TableInfo;
import com.baomidou.mybatisplus.generator.config.rules.NamingStrategy;
import com.baomidou.mybatisplus.generator.engine.FreemarkerTemplateEngine;
import com.baomidou.mybatisplus.generator.model.ClassAnnotationAttributes;
import io.jiangbyte.framework.pojo.BaseEntity;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @author ZhangJiangHu
 * @version v1.0
 * @date 28/09/2025
 * @description TODO
 */
public class FrontendGen {
    public static void execute(List<Module> modules, String dataBaseUrl, String dataBaseUserName, String dataBasePassword, String author, String outputDir) {

        DataSourceConfig.Builder datasourceBuilder = new DataSourceConfig.Builder(dataBaseUrl, dataBaseUserName, dataBasePassword);

        for (Module module : modules) {
            FastAutoGenerator.create(datasourceBuilder)
                    /**
                     * 全局配置
                     * 可以配置作者、目录这些
                     */
                    .globalConfig(builder -> {
                        builder.author(author) // 作者
                                .disableOpenDir() // 禁止打开输出目录
                                .enableSpringdoc()
                                .outputDir(outputDir); // 指定输出目录
                    })

                    /**
                     * 包配置
                     */
                    .packageConfig(builder -> builder
                            .parent("vue") // 设置父包名
                    )

                    /**
                     * 策略配置
                     */
                    .strategyConfig(builder -> builder
                            .addInclude(module.getTables()) // 设置需要生成的表名

                            /**
                             * Entity
                             */
                            .entityBuilder()
                            .disable()

                            /**
                             * Service
                             */
                            .serviceBuilder()
                            .disable()

                            /**
                             * Mapper
                             */
                            .mapperBuilder()
                            .disable()

                            /**
                             * Controller
                             */
                            .controllerBuilder()
                            .disable()

                    )
                    .injectionConfig(injectConfig -> {
                        List<CustomFile> build = new ArrayList<>();

                        List<CustomFile> build2 = List.of(
                                /* ====================================================== API ====================================================== */
                                new CustomFile.Builder()
                                        .fileName("Api.ts")
                                        .formatNameFunction(tableInfo -> tableInfo.getEntityName().toLowerCase() + "/")
                                        .templatePath("/api/Api.ts.ftl")
                                        .enableFileOverride() // 覆盖已生成文件
                                        .packageName("api." + module.getGModule())
                                        .build(),

                                /* ====================================================== API VUE 文件 ====================================================== */
                                new CustomFile.Builder()
                                        .fileName("constant.ts")
                                        .formatNameFunction(tableInfo -> tableInfo.getEntityName().toLowerCase() + "/")
                                        .templatePath("/vue/v1/constant.ts.ftl")
                                        .enableFileOverride() // 覆盖已生成文件
                                        .packageName(module.getGModule())
                                        .build(),
                                new CustomFile.Builder()
                                        .fileName("index.vue")
                                        .formatNameFunction(tableInfo -> tableInfo.getEntityName().toLowerCase() + "/")
                                        .templatePath("/vue/v1/index.vue.ftl")
                                        .enableFileOverride() // 覆盖已生成文件
                                        .packageName(module.getGModule())
                                        .build(),
                                new CustomFile.Builder()
                                        .fileName("form.vue")
                                        .formatNameFunction(tableInfo -> tableInfo.getEntityName().toLowerCase() + "/")
                                        .templatePath("/vue/v1/form.vue.ftl")
                                        .enableFileOverride() // 覆盖已生成文件
                                        .packageName(module.getGModule())
                                        .build(),
                                new CustomFile.Builder()
                                        .fileName("detail.vue")
                                        .formatNameFunction(tableInfo -> tableInfo.getEntityName().toLowerCase() + "/")
                                        .templatePath("/vue/v1/detail.vue.ftl")
                                        .enableFileOverride() // 覆盖已生成文件
                                        .packageName(module.getGModule())
                                        .build(),
                                new CustomFile.Builder()
                                        .fileName("Menu.sql")
                                        .templatePath("/backend/menu.sql.ftl")
                                        .packageName("sql." + module.getGModule())
                                        .enableFileOverride()
                                        .build()
                        );
                        build.addAll(build2);

                        injectConfig
                                .customMap(Map.of(
                                        "GModule", module.getGModule(),
                                        "ModuleName", module.getModuleName()
                                ))
                                .customFile(build);
                    })
                    .templateEngine(new FreemarkerTemplateEngine())
                    .execute();
        }
    }
}
